require 'spec_helper'

describe BitPay::KeyUtils do
  let(:key_utils) {BitPay::KeyUtils}

  describe '.generate_pem' do
    it 'should generate a pem string' do
      regex = /BEGIN\ EC\ PRIVATE\ KEY/
      expect(regex.match(key_utils.generate_pem)).to be_truthy
    end
  end
  
  describe '.get_public_key_from_pem' do
    it 'should generate the right public key' do
      expect(key_utils.get_public_key_from_pem(PEM)).to eq(PUB_KEY)
    end
    
    it 'should get pem from the env if none is passed' do
      expect(key_utils.get_public_key_from_pem(PEM)).to eq(PUB_KEY)
    end

  end

  describe '.generate_sin_from_pem' do
    let(:pem){PEM}
    let(:sin){CLIENT_ID}

    it 'will return the right sin for the right pem' do
      expect(key_utils.generate_sin_from_pem(pem)).to eq sin
    end
  end

  describe '.sign_with_pem' do
    it "should provide a valid signature" do
      message = "hello cincinatti"
      digest = Digest::SHA256.digest(message)

      pem = PEM
      signature = key_utils.sign_with_pem pem, message

      priv= OpenSSL::PKey::EC.new(pem).private_key.to_i
      group = ECDSA::Group::Secp256k1
      pk = group.generator.multiply_by_scalar(priv)
      decoded = ECDSA::Format::SignatureDerString.decode(signature.to_i(16).to_bn.to_s(2))
      valid = ECDSA.valid_signature?(pk, digest, decoded)
      expect(valid).to be(true)
    end
  end

  context "errors when priv_key is not provided" do
    it 'will not retrieve public key' do 
      expect{key_utils.get_public_key_from_pem(nil)}.to raise_error(BitPay::BitPayError) 
    end

  end 
  
end

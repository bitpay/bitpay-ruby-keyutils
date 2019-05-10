require './lib/bitpay/key_version.rb'
Gem::Specification.new do |s|
  s.name = 'bitpay-key-utils'
  s.version = BitPay::KEY_UTILS_VERSION
  s.licenses = ['MIT']
  s.authors = 'Bitpay, Inc.'
  s.email = 'sales-engineering@bitpay.com'
  s.homepage = 'https://github.com/bitpay/bitpay-ruby-keyutils'
  s.summary = 'Official Ruby library for the BitPay API'
  s.description = 'Powerful, flexible, lightweight, thread-safe interface to the BitPay developers API'

  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.rubyforge_project = s.name
  s.required_ruby_version = '>= 2.0'
  s.bindir        = 'bin'
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_dependency 'ecdsa',     '~> 1.2'

  s.add_development_dependency 'rake', '12.0'
  s.add_development_dependency 'pry', '0.12'
  s.add_development_dependency 'pry-byebug', '2.0.0'
  s.add_development_dependency 'pry-rescue', '1.4.1'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'coveralls'
end

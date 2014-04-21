# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/fluxapp/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-fluxapp"
  spec.version       = Omniauth::Fluxapp::VERSION
  spec.authors       = ["soorajtp"]
  spec.email         = ["soorajtp@foradian.com"]
  spec.summary       = %q{OAuth2 client for fluxapp.}
  spec.description   = %q{Centralized login for in-house apps using flux.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency 'omniauth'#, '~> 1.0'
  spec.add_dependency 'omniauth-oauth2'#, '~> 1.1'
  spec.add_development_dependency 'rspec', '~> 2.7'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'

end

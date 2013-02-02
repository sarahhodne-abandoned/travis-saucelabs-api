# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'travis-saucelabs-api/version'

Gem::Specification.new do |gem|
  gem.name          = "travis-saucelabs-api"
  gem.version       = Travis::SaucelabsAPI::VERSION
  gem.authors       = ["Henrik Hodne"]
  gem.email         = ["me@henrikhodne.com"]
  gem.description   = %q{Ruby client library for the API Travis uses to spin up OS X VMs}
  gem.summary       = %q{Travis/Sauce Labs API client}
  gem.homepage      = 'https://github.com/henrikhodne/travis-saucelabs-api'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency('faraday', '~> 0.7')
  gem.add_runtime_dependency('faraday_middleware', '~> 0.9')
  gem.add_runtime_dependency('thor', '~> 0.17')
end

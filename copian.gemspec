# -*- encoding: utf-8 -*-
require File.expand_path('../lib/copian/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Geoff Garside"]
  gem.email         = ["geoff@geoffgarside.co.uk"]
  gem.description   = %q{Suite of SNMP collectors for different types of network devices}
  gem.summary       = %q{SNMP Information statistics}
  gem.homepage      = "http://github.com/geoffgarside/copian"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "copian"
  gem.require_paths = ["lib"]
  gem.version       = Copian::VERSION

  gem.add_dependency "snmp", ">= 1.0.4"
end

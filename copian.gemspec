# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{copian}
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Geoff Garside"]
  s.date = %q{2009-10-05}
  s.description = %q{Suite of SNMP collectors for different types of network devices}
  s.email = %q{geoff@geoffgarside.co.uk}
  s.extra_rdoc_files = [
    "LICENSE",
     "README"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README",
     "Rakefile",
     "VERSION.yml",
     "copian.gemspec",
     "lib/copian.rb",
     "lib/copian/collector/abstract_collector.rb",
     "lib/copian/collector/addresses_collector.rb",
     "lib/copian/collector/bandwidth_collector.rb",
     "lib/copian/collector/cisco.rb",
     "lib/copian/collector/cisco/addresses.rb",
     "lib/copian/collector/cisco/ports.rb",
     "lib/copian/collector/cisco/vlans.rb",
     "lib/copian/collector/dell.rb",
     "lib/copian/collector/dell/ports.rb",
     "lib/copian/collector/dell/vlans.rb",
     "lib/copian/collector/generic.rb",
     "lib/copian/collector/hp.rb",
     "lib/copian/collector/hp/ports.rb",
     "lib/copian/collector/hp/vlans.rb",
     "lib/copian/collector/port_stats_collector.rb",
     "lib/copian/collector/ports_collector.rb",
     "test/copian_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/geoffgarside/copian}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Suite of SNMP collectors for different types of network devices}
  s.test_files = [
    "test/copian_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<snmp>, [">= 1.0.2"])
    else
      s.add_dependency(%q<snmp>, [">= 1.0.2"])
    end
  else
    s.add_dependency(%q<snmp>, [">= 1.0.2"])
  end
end

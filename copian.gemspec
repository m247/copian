# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{copian}
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Geoff Garside"]
  s.date = %q{2009-02-04}
  s.description = %q{TODO}
  s.email = %q{geoff@geoffgarside.co.uk}
  s.files = ["VERSION.yml", "lib/copian", "lib/copian/collector", "lib/copian/collector/abstract_collector.rb", "lib/copian/collector/addresses_collector.rb", "lib/copian/collector/cisco", "lib/copian/collector/cisco/addresses.rb", "lib/copian/collector/cisco/ports.rb", "lib/copian/collector/cisco/vlans.rb", "lib/copian/collector/cisco.rb", "lib/copian/collector/dell", "lib/copian/collector/dell/ports.rb", "lib/copian/collector/dell.rb", "lib/copian/collector/generic.rb", "lib/copian/collector/hp", "lib/copian/collector/hp/ports.rb", "lib/copian/collector/hp.rb", "lib/copian/collector/port_stats_collector.rb", "lib/copian/collector/ports_collector.rb", "lib/copian.rb", "test/copian_test.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/geoffgarside/copian}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Suite of SNMP collectors for different types of network devices}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<snmp>, [">= 1.0.2"])
    else
      s.add_dependency(%q<snmp>, [">= 1.0.2"])
    end
  else
    s.add_dependency(%q<snmp>, [">= 1.0.2"])
  end
end

require File.expand_path(File.dirname(__FILE__) + '/cisco/addresses')
require File.expand_path(File.dirname(__FILE__) + '/cisco/ports')
require File.expand_path(File.dirname(__FILE__) + '/cisco/vlans')

module Copian
  module Collector
    class Cisco < Generic
      def vlans
        load_ifnames

        vlans_collector.collect do |vlan_id, vlan_index|
          yield vlan_id, vlan_index, @ifnames[vlan_index]
        end
      end
      def addresses
        addresses_collector.collect do |mac, ips|
          yield mac, ips
        end
      end
      def ports
        load_ifnames

        ports_collector.collect do |port_ifindex, port_addresses|
          yield port_ifindex, @ifnames[port_ifindex], port_addresses
        end
      end
      private
        def vlans_collector
          @vlans_collector ||= CiscoVlansCollector.new(@manager)
        end
        def addresses_collector
          @addresses_collector ||= CiscoAddressesCollector.new(@manager)
        end
        def ports_collector
          @ports_collector ||=
            CiscoPortsCollector.new(@manager, vlans_collector)
        end
    end
  end
end

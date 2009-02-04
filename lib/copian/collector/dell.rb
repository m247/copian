require File.expand_path(File.dirname(__FILE__) + '/dell/ports')
require File.expand_path(File.dirname(__FILE__) + '/dell/vlans')

module Copian
  module Collector
    class Dell < Generic
      def vlans # :yields: id, ifindex, name
        load_ifnames

        vlans_collector.collect do |vlan_id, vlan_index|
          yield vlan_id, vlan_index, @ifnames[vlan_index]
        end
      end
      def ports # :yields: ifindex, ifname, addresses_array
        load_ifnames

        ports_collector.collect do |port_ifindex, port_addresses|
          yield port_ifindex, @ifnames[port_ifindex], port_addresses
        end
      end
      private
        def vlans_collector
          @vlans_collector ||= DellVlansCollector.new(@manager)
        end
        def ports_collector
          @ports_collector ||=
            DellPortsCollector.new(@manager)
        end
    end
  end
end

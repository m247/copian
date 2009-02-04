require File.expand_path(File.dirname(__FILE__) + '/hp/ports')
require File.expand_path(File.dirname(__FILE__) + '/hp/vlans')

module Copian
  module Collector
    class Hp < Generic
      def vlans
        load_ifnames

        vlans_collector.collect do |vlan_id, vlan_index|
          vlan_name = @ifnames[vlan_index]
          vlan_id = vlan_name.gsub(/[^0-9]/, '').to_i
          yield vlan_id, vlan_index, vlan_name
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
          @vlans_collector ||= HpVlansCollector.new(@manager)
        end
        def ports_collector
          @ports_collector ||=
            HpPortsCollector.new(@manager)
        end
    end
  end
end

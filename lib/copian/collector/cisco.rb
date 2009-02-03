require File.expand_path(File.dirname(__FILE__) + '/cisco/addresses')
require File.expand_path(File.dirname(__FILE__) + '/cisco/ports')
require File.expand_path(File.dirname(__FILE__) + '/cisco/vlans')

module Copian
  module Collector
    class Cisco
      def inspect
        "#<#{self.class} #{@manager.host}@#{@manager.community}>"
      end
      def initialize(ip_addr, community, version = :SNMPv2c)
        @manager = SNMP::Manager.new(:Host => ip_addr,
          :Community => community, :Version => version)
      end
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
        def load_ifnames
          return if @loaded_ifnames
          oid = SNMP::ObjectId.new('1.3.6.1.2.1.31.1.1.1.1')
          @manager.walk(oid) do |r|
            r.each do |varbind|
              append_ifname(varbind.name.index(oid).to_s.to_i,
                varbind.value.to_s)
            end
          end
          @loaded_ifnames = true
        end
        def append_ifname(ifindex, ifname)
          @ifnames ||= Hash.new
          @ifnames[ifindex] = ifname
        end
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

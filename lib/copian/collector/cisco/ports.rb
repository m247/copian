module Copian
  module Collector
    class CiscoPortsCollector < PortsCollector # :nodoc:
      def initialize(manager, vlans_collector)
        super(manager)
        @vlans_collector = vlans_collector
      end
      def collect
        each_vlan do |manager|
          mac_bridge_ports = gather_mac_bridge_ports(manager)
          bridge_port_iface = gather_bridge_port_ifaces(manager)

          # Now we stitch the two lists together
          mac_bridge_ports.each do |bridge_port, addresses|
            yield bridge_port_iface[bridge_port], addresses
          end
        end
      end
      private
        def each_vlan
          @vlans_collector.collect do |vlan_id, vlan_index|
            yield SNMP::Manager.new(:Host => @manager.host,
              :Version => @manager.version,
              :Community => "#{@manager.community}@#{vlan_id}")
          end
        end
        def gather_mac_bridge_ports(manager)
          oid = SNMP::ObjectId.new('1.3.6.1.2.1.17.4.3.1.2')
          mac_bridge_ports = Hash.new

          manager.walk(oid) do |r|
            r.each do |varbind|
              mac_bridge_ports[varbind.value.to_i] ||= Array.new
              mac_bridge_ports[varbind.value.to_i] << 
                suboid_to_mac(varbind.name.index(oid))
            end
          end

          mac_bridge_ports
        end
        def gather_bridge_port_ifaces(manager)
          oid = SNMP::ObjectId.new('1.3.6.1.2.1.17.1.4.1.2')
          bridge_port_ifaces = Hash.new

          manager.walk(oid) do |r|
            r.each do |varbind|
              bridge_port_ifaces[varbind.name.index(oid).to_s.to_i] =
                varbind.value.to_i
            end
          end

          bridge_port_ifaces
        end
    end
  end
end

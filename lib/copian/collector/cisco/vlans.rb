module Copian
  module Collector
    class CiscoVlansCollector < AbstractCollector
      def collect
        oid = SNMP::ObjectId.new('1.3.6.1.4.1.9.9.46.1.3.1.1.18.1')
        @manager.walk(oid) do |r|
          r.each do |varbind|
            vlan_id      = varbind.name.index(oid).to_s.to_i
            vlan_ifindex = varbind.value.to_i

            # NOTE: Ignore ids between 1002 and 1005 they are seemingly fake
            next if vlan_id.between?(1002, 1005)
            yield vlan_id, vlan_ifindex
          end
        end
      end
    end
  end
end

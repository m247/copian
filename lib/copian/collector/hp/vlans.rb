module Copian
  module Collector
    class HpVlansCollector < AbstractCollector # :nodoc:
      def collect
        oid = SNMP::ObjectID.new('1.3.6.1.2.1.2.2.1.3')
        @manager.walk(oid) do |r|
          r.each do |varbind|
            next unless varbind.value.to_i == 53  # propVirtual type
            vlan_index = varbind.name.index(oid).to_s.to_i
            # Not sure how to get this vlan ID, ifName sort of has it

            yield nil, vlan_index
          end
        end
      end
    end
  end
end

module Copian
  module Collector
    class DellVlansCollector < AbstractCollector # :nodoc:
      # ---
      # Dell switches assign VLANs ifIndex values equal to
      # the VLAN ID + 100000.
      # +++
      def collect
        oid = SNMP::ObjectID.new('1.3.6.1.2.1.2.2.1.3')
        @manager.walk(oid) do |r|
          r.each do |varbind|
            next unless varbind.value.to_i == 53  # propVirtual type
            vlan_index = varbind.name.index(oid).to_s.to_i
            vlan_id = vlan_index - 100000
            vlan_id = 1 if vlan_id == 0

            yield vlan_id, vlan_index
          end
        end
      end
    end
  end
end

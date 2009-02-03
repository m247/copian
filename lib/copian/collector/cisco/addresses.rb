module Copian
  module Collector
    class CiscoAddressesCollector < AddressesCollector
      def collect
        oid = SNMP::ObjectId.new('1.3.6.1.2.1.4.22.1.2')
        @manager.walk(oid) do |r|
          r.each do |varbind|
            mac_addr = value_to_mac_address(varbind.value)
            ip_addr  = name_to_ip_address(varbind.name, oid)
            append_mac_and_ip(mac_addr, ip_addr)
          end
        end

        @map.each do |mac, ips|
          yield mac.dup, ips if block_given?
        end
      end
    end
  end
end

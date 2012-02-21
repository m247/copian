module Copian
  module Collector
    class CiscoAddressesCollector < AddressesCollector # :nodoc:
      IpNetToMediaPhysAddress     = SNMP::ObjectId.new('1.3.6.1.2.1.4.22.1.2')  # IPv4 only
      IpNetToPhysicalPhysAddresss = SNMP::ObjectId.new('1.3.6.1.2.1.4.35.1.4')  # IP version agnostic

      def collect
        oid = IpNetToMediaPhysAddress

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
      protected
        def name_to_ip_address(name, oid)
          if oid == IpNetToMediaPhysAddress
            # Strip off the parent and IDX oid
            # the rest is an IPv4 address
            name.index(oid)[1..-1].to_s
          elsif oid == IpNetToPhysicalPhysAddresss
            # Strip off the parent and IDX oid
            sub = name.index(oid)[1..-1]
            family = sub.shift
            addrlen = sub.shift

            case family
            when 1  # IPv4
              sub[0..addrlen].to_s
            when 2  # IPv6
              sub[0..addrlen].map do |i|
                "%02x" % i.to_i
              end.join.split(/([a-f0-9]{4})/).reject do |i|
                i == ""
              end.join(":")
            end
          end
        end
    end
  end
end

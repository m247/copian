module Copian
  module Collector
    class AddressesCollector < AbstractCollector
      protected
        def append_mac_and_ip(mac, ip)
          @map ||= Hash.new
          @map[mac] ||= Array.new
          @map[mac] << ip
        end
        def value_to_mac_address(value)
          value.unpack('H2' * 6).join(':')
        end
        def name_to_ip_address(name, oid)
          name.index(oid).to_s.gsub(/^[0-9]+\./, '')
        end
    end
  end
end

module Copian
  module Collector
    class PortsCollector < AbstractCollector
      protected
        def suboid_to_mac(oid)
          oid.to_s.split('.').collect { |i|
            i.to_i
          }.pack('C' * 6).unpack('H2' * 6).join(':')
        end
    end
  end
end

module Copian
  module Collector
    class HpPortsCollector < PortsCollector
      def collect
        oid = SNMP::ObjectId.new('1.3.6.1.4.1.11.2.14.11.5.1.9.4.2.1.1.2')
        results = Hash.new

        manager.walk(oid) do |r|
          r.each do |varbind|
            results[varbind.value.to_i] ||= Array.new
            results[varbind.value.to_i] << suboid_to_mac(varbind.name.index(oid))
          end
        end

        results.each do |if_index, addresses|
          yield if_index, addresses
        end
      end
      protected
        def suboid_to_mac(oid)
          super(oid.to_s.gsub(/^[0-9]+\./, ''))
        end
    end
  end
end
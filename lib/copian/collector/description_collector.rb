module Copian
  module Collector
    class DescriptionCollector < AbstractCollector # :nodoc:
      def collect
        oid = SNMP::ObjectId.new('1.3.6.1.2.1.2.2.1.2')
        @manager.walk(oid) do |r|
          r.each do |varbind|
            yield varbind.name.index(oid), varbind.value.to_s
          end
        end
      end
    end
  end
end

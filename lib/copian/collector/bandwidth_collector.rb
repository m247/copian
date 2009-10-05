module Copian
  module Collector
    class BandwidthCollector < AbstractCollector # :nodoc:
      def initialize(manager)
        super(manager)
      end
      def collect
        load_inoctets
        load_outoctets

        @interfaces.each do |ifindex, stats|
          yield ifindex, stats[:inoctets], stats[:outoctets]
        end
      end
      def collect64
        load_inoctets64
        load_outoctets64

        @interfaces.each do |ifindex, stats|
          yield ifindex, stats[:inoctets64], stats[:outoctets64]
        end
      end
      protected
        def load_inoctets
          load_property(:inoctets, SNMP::ObjectId.new('1.3.6.1.2.1.2.2.1.10'))
        end
        def load_outoctets
          load_outoctets(:outoctets, SNMP::ObjectId.new('1.3.6.1.2.1.2.2.1.16'))
        end
        def load_inoctets64
          load_property(:inoctets64, SNMP::ObjectId.new('1.3.6.1.2.1.31.1.1.1.6'))
        end
        def load_outoctets64
          load_outoctets(:outoctets64, SNMP::ObjectId.new('1.3.6.1.2.1.31.1.1.1.10'))
        end
        def load_property(property, oid)
          @manager.walk(oid) do |r|
            r.each do |varbind|
              append_property(varbind.name.index(oid), property,
                varbind.value.to_i)
            end
          end
        end
        def append_property(index, property, value)
          @interfaces[index.to_s.to_i] ||= Hash.new
          @interfaces[index.to_s.to_i][property] = value
        end
        
    end
  end
end

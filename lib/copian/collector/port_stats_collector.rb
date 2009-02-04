module Copian
  module Collector
    class PortStatsCollector < AbstractCollector
      def initialize(manager)
        super(manager)
        @interfaces = Hash.new
      end
      def collect
        load_mtu
        load_speed
        load_oper_status
        load_admin_status

        @interfaces.each do |ifindex, p|
          yield ifindex, p[:mtu], p[:speed], p[:admin_status], p[:oper_status]
        end
      end
      protected
        def load_mtu
          load_property(:mtu, SNMP::ObjectId.new('1.3.6.1.2.1.2.2.1.4'))
        end
        def load_speed
          load_property(:speed, SNMP::ObjectId.new('1.3.6.1.2.1.2.2.1.5'))
        end
        def load_admin_status
          load_property(:admin_status, SNMP::ObjectId.new('1.3.6.1.2.1.2.2.1.7'))
        end
        def load_oper_status
          load_property(:oper_status, SNMP::ObjectId.new('1.3.6.1.2.1.2.2.1.8'))
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

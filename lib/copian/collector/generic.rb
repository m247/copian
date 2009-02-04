module Copian
  module Collector
    class Generic
      def inspect
        "#<#{self.class} #{@manager.host}@#{@manager.community}>"
      end
      def initialize(ip_addr, community, version = :SNMPv2c)
        @manager = SNMP::Manager.new(:Host => ip_addr,
          :Community => community, :Version => version)
      end
      protected
        def load_ifnames
          return if @loaded_ifnames
          oid = SNMP::ObjectId.new('1.3.6.1.2.1.31.1.1.1.1')
          @manager.walk(oid) do |r|
            r.each do |varbind|
              append_ifname(varbind.name.index(oid).to_s.to_i,
                varbind.value.to_s)
            end
          end
          @loaded_ifnames = true
        end
        def append_ifname(ifindex, ifname)
          @ifnames ||= Hash.new
          @ifnames[ifindex] = ifname
        end
    end
  end
end

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
      def port_stats # :yields: ifindex, name, mtu, speed, admin_status, oper_status
        load_ifnames

        port_stats_collector.collect do |ifindex, mtu, speed, admin_status, oper_status|
          yield ifindex, @ifnames[ifindex], mtu, speed, admin_status, oper_status
        end
      end

      # Collect bandwidth statistics
      #
      # Arguments:
      #   +options+
      #
      # Valid Options
      #   +:64bit+  :Set to true to enable 64bit bandwidth collection. Default false.
      def bandwidth(options = {}) # :yields: ifindex, inoctets, outoctets
        load_ifnames

        collect_method = options[:64bit] == true ? :collect64 : :collect
        bandwidth_collector.send(collect_method) do |ifindex, inoctets, outoctets|
          yield ifindex, @ifnames[ifindex], inoctets, outoctets
        end
      end
      protected
        # :stopdoc:
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
        def port_stats_collector
          @port_stats_collector ||= PortStatsCollector.new(@manager)
        end
        def bandwidth_collector
          @bandwidth_collector ||= BandwidthCollector.new(@manager)
        end
        # :startdoc:
    end
  end
end

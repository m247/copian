require File.expand_path(File.dirname(__FILE__) + '/dell/ports')

module Copian
  module Collector
    class Dell < Generic
      def ports
        load_ifnames

        ports_collector.collect do |port_ifindex, port_addresses|
          yield port_ifindex, @ifnames[port_ifindex], port_addresses
        end
      end
      private
        def ports_collector
          @ports_collector ||=
            DellPortsCollector.new(@manager)
        end
    end
  end
end

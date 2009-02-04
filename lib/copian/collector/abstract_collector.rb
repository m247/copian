module Copian
  module Collector
    class AbstractCollector # :nodoc:
      def initialize(manager)
        @manager = manager
      end
      def collect
        raise NoMethodError, "You must implement a collect method"
      end
    end
  end
end

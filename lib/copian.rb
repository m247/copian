require 'snmp'

require 'copian/version'
require 'copian/collector/abstract_collector'
require 'copian/collector/addresses_collector'
require 'copian/collector/bandwidth_collector'
require 'copian/collector/description_collector'
require 'copian/collector/ports_collector'
require 'copian/collector/port_stats_collector'
require 'copian/collector/generic'
require 'copian/collector/cisco'
require 'copian/collector/dell'
require 'copian/collector/hp'

# :stopdoc:
class SNMP::Manager
  attr_reader :host, :community, :version
end
# :startdoc:

module Copian # :nodoc:
  module Collector # :nodoc:
  end
end

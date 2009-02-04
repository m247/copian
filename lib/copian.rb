require 'copian/collector/abstract_collector'
require 'copian/collector/addresses_collector'
require 'copian/collector/ports_collector'
require 'copian/collector/port_stats_collector'
require 'copian/collector/generic'
require 'copian/collector/cisco'
require 'copian/collector/dell'
require 'copian/collector/hp'

require 'snmp'

class SNMP::Manager
  attr_reader :host, :community, :version
end

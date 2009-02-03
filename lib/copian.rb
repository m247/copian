require 'copian/collector/abstract_collector'
require 'copian/collector/addresses_collector'
require 'copian/collector/ports_collector'
require 'copian/collector/cisco'

require 'snmp'

class SNMP::Manager
  attr_reader :host, :community, :version
end

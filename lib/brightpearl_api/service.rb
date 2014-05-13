require 'brightpearl_api/services/contact'
require 'brightpearl_api/services/order'
require 'brightpearl_api/services/product'
require 'brightpearl_api/services/warehouse'

module BrightpearlApi
  class Service
    include Contact
    include Order
    include Product
    include Warehouse

    def initialize
      raise BrightpearlException, "Configuration is invalid" unless Configuration.instance.valid?
    end

    def call(type, path, data = {})
      Client.instance.call(type, path, data)
    end

    def parse_idset(idset)
      id_set = nil
      case idset
      when Array, Range
        id_set = "#{idset.min.to_int}-#{idset.max.to_int}"
      else
        id_set = idset.to_int
      end
      id_set
    end
  end
end

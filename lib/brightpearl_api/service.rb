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
      when Range
        id_set = "#{idset.min.to_int}-#{idset.max.to_int}"
      when Array
        id_set = idset.collect{ |x| x.to_int }.join(',')
      else
        id_set = idset.to_int
      end
      id_set
    end

    def create_resource(service, resource)
      body = {}
      yield(body)
      call(:post, "/#{service}-service/#{resource}/", body)
    end

    def get_resource(service, resource, idset = nil)
      if !idset.nil?
        id_set = parse_idset(idset)
        call(:get, "/#{service}-service/#{resource}/#{id_set}")
      else
        call(:get, "/#{service}-service/#{resource}")
      end
    end

    def get_resource_range(service, resource, idset = nil)
      if !idset.nil?
        id_set = parse_idset(idset)
        call(:options, "/#{service}-service/#{resource}/#{id_set}")
      else
        call(:options, "/#{service}-service/#{resource}")
      end
    end
  end
end

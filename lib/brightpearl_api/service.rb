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
        id_set = "#{idset.min.to_i}-#{idset.max.to_i}"
      when Array
        id_set = idset.collect{ |x| x.to_i }.join(',')
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

    def update_resource(service, resource, resource_id)
      body = {}
      yield(body)
      call(:put, "/#{service}-service/#{resource}/#{resource_id.to_i}", body)
    end

    def delete_resource(service, resource, resource_id)
      call(:delete, "/#{service}-service/#{resource}/#{resource_id.to_i}")
    end

    def get_resource_range(service, resource, idset = nil)
      if !idset.nil?
        id_set = parse_idset(idset)
        call(:options, "/#{service}-service/#{resource}/#{id_set}")
      else
        call(:options, "/#{service}-service/#{resource}")
      end
    end

    def search_resource(service, resource)
      body = {}
      yield(body)
      result_hash = []
      response = call(:get, "/#{service}/#{resource}-search?#{body.to_query}")
      properties = response['metaData']['columns'].map { |x| x['name'] }
      response['results'].each do |result|
        hash = {}
        properties.each_with_index do |item, index|
          hash[item] = result[index]
        end
        result_hash << hash
      end
      result_hash
    end
  end
end

module BrightpearlApi
  class Service
    def initialize
      raise BrightpearlException, "Configuration is invalid" unless Configuration.instance.valid?
    end

    def call(type, path, data = {})
      Client.instance.call(type, path, data)
    end
  end
end

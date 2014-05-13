require 'singleton'

module BrightpearlApi
  class Configuration
    include Singleton

    attr_accessor :email, :password, :version, :datacenter, :account

    def self.instance
      @@instance ||= new
    end

    def init(args = {})
      @email = default_email
      @password = default_password
      @version = default_version
      @datacenter = default_datacenter
      @account = default_account
      args.each_pair do |option, value|
        self.send("#{option}=", value)
      end
    end

    def valid?
      result = true
      [:email, :password, :version, :datacenter, :account].each do |value|
        result = false if self.send(value).blank?
      end
      result
    end

    def uri(path)
      "https://" + @datacenter + ".brightpearl.com/" + @version + "/" + @account + path
    end

    def auth_uri
      uri('/authorise').sub("/" + @version, "")
    end

    private
    def default_email
      ENV['BRIGHTPEARL_EMAIL']
    end

    def default_password
      ENV['BRIGHTPEARL_PASSWORD']
    end

    def default_version
      ENV['BRIGHTPEARL_VERSION']
    end

    def default_datacenter
      ENV['BRIGHTPEARL_DATACENTER']
    end

    def default_account
      ENV['BRIGHTPEARL_ACCOUNT']
    end
  end
end

require "active_support/all"
require "brightpearl_api/version"
require 'brightpearl_api/configuration'
require 'brightpearl_api/client'

module BrightpearlApi
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.call(type, path, data = {})
    Client.instance.call(type, path, data)
  end
end

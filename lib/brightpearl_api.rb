require "active_support/all"
require "brightpearl_api/version"
require 'brightpearl_api/configuration'
require 'brightpearl_api/client'
require 'brightpearl_api/service'

module BrightpearlApi
  class << self
    attr_accessor :configuration
  end

  class AuthException < StandardError; end
  class BrightpearlException < StandardError; end

  def self.configure
    Configuration.instance.init
    self.configuration ||= Configuration.instance
    yield(configuration)
  end
end

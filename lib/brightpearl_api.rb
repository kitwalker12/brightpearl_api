require "active_support/all"
require "brightpearl_api/version"
require 'brightpearl_api/configuration'

module BrightpearlApi
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end

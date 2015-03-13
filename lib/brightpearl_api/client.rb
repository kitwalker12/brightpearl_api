require 'singleton'
require 'httparty'
require 'curb'

module BrightpearlApi
  class Client
    include Singleton

    @@token = false

    def self.instance
      @@instance ||= new
    end

    def call(type, path, data = {})
      api_call(type, path, data)
    rescue AuthException => e
      reset_token
      api_call(type, path, data)
    rescue ThrottleException => e
      sleep(60.seconds)
      reset_token
      api_call(type, path, data)
    rescue DatabaseException => e
      sleep(1.seconds)
      api_call(type, path, data)
    end

    def api_call(type, path, data = {})
      token = authenticate

      uri = configuration.uri(path)
      options = {
        :headers => {
          'Content-Type' => 'application/json',
          'Accept' => 'json',
          'brightpearl-auth' => token
        },
        :body => data.to_json
      }
      if type == :get
        response = HTTParty.get(uri, options)
      elsif type == :post
        response = HTTParty.post(uri, options)
      elsif type == :put
        response = HTTParty.put(uri, options)
      elsif type == :options
        http = Curl.options(uri) do|http|
          http.headers = options[:headers]
        end
        response = JSON.parse(http.body_str)
      elsif type == :delete
        response = HTTParty.delete(uri, options)
      end
      check_response(response)
      return response["response"]
    end

    def authenticate
      return @@token unless @@token.blank?
      options = {
        :headers => {
          'Content-Type' => 'application/json',
          'Accept' => 'json'
        },
        :body => {
          :apiAccountCredentials => {
            :emailAddress => configuration.email,
            :password => configuration.password
          }
        }.to_json
      }
      response = HTTParty.post(configuration.auth_uri, options)
      check_response(response)
      @@token = response["response"]
    end

    def reset_token
      @@token = false
    end

    private

    def configuration
      BrightpearlApi.configuration
    end

    def check_response(response)
      if(!response['errors'].blank?)
        reset_token
        if response['errors'].is_a? Array
          if response['errors'][0].fetch('message', '').include? 'Could not create connection to database server'
            raise DatabaseException, "#{response.to_json}"
          end
        end
        raise BrightpearlException, "#{response.to_json}"
      end
      if (response['response'].is_a? String) && (response['response'].include? 'Not authenticated')
        raise AuthException, "#{response.to_json}"
      end
      if (response['response'].is_a? String) && (response['response'].include? 'Please wait before sending another request')
        raise ThrottleException, "#{response.to_json}"
      end
    end
  end
end

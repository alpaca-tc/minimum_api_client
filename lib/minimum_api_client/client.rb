# Minimum client for API
module MinimumApiClient
  class Client
    def initialize(options = {}, &block)
      @connection ||= Faraday.new(default_options.merge(options)) do |conn|
        block.call(conn) if block_given?

        # Set default middleware
        conn.adapter Faraday.default_adapter
      end
    end

    %i(get post patch put delete).each do |http_method|
      define_method http_method do |path, params = nil, headers = nil|
        process(http_method, path, params, headers)
      end
    end

    private

    def default_options
      { headers: default_headers, url: url_prefix }
    end

    def default_headers
      {}
    end

    def host
      NotImplementedError
    end

    def path_prefix
      NotImplementedError
    end

    def protocol
      'http'
    end

    def process(request_method, path, params, headers)
      faraday_response = @connection.send(request_method, path, params, headers)
      Response.new(faraday_response)
    end

    def url_prefix
      "#{protocol}://#{host}#{path_prefix}"
    end
  end
end

require 'active_support/core_ext/string'

module MinimumApiClient
  class ResponseRenderer
    def initialize(response)
      @response = response
    end

    def to_s
      <<-EOS.gsub(/^ {6}/, '')
      HTTP/1.1 #{status}
      #{headers}
      #{body}
      EOS
    end

    private

    def headers
      @response.headers.sort.map { |key, value|
        pair = {
          key: key.split('-').map(&:camelize).join('-'),
          value: value
        }

        sprintf('%{key}: %{value}', pair)
      }.join("\n")
    end

    def status
      "#{@response.status} #{@response.status_message}"
    end

    def body
      return '' unless has_body?

      # XXX
      case @response.headers['Content-Type']
      when %r{text/html}
        @response.body + "\n"
      when %r{application/json}
        require 'json'
        JSON.pretty_generate(@response.body) + "\n"
      else
        raise 'Unsupported Content-Type given ', @response.headers['Content-Type']
      end
    end

    def has_body?
      @response.status != 204
    end
  end
end

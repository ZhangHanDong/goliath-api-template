require 'em-synchrony'
require 'em-synchrony/em-http'

module Tools
  module HttpBase
    class Client

      def initialize(options = {})
        @options = options.symbolize_keys
      end

      def remote_request(http_method, url, options = {})
        case http_method
        when 'post'
          if (Goliath.env?(:development) || Goliath.env?(:test))
            Net::HTTP.post_form(URI.parse(generate_url(url)), options).body
          else
            remote_req = EM::HttpRequest
                       .new(URI.parse(generate_url(url)))
                       .post(:body => options, :head => {:accept => "application/json" })
            remote_req.response
          end
        when 'get'
          if (Goliath.env?(:development) || Goliath.env?(:test))
            Net::HTTP.get(URI.parse(generate_url(url, options)))
          else
            remote_req = EM::HttpRequest
                       .new(URI.parse(generate_url(url)))
                       .get(:query => options, :head => {:accept => "application/json" })
            remote_req.response
          end
        end
      end

    end
  end
end

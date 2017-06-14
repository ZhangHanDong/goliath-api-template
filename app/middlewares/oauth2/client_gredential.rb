require 'base64'
require 'yaml'

# usage:
#   use Goliath::Rack::SimpleAroundwareFactory, Middlewares::OAuth2::ClientGredential
#
# by blackanger


module Middlewares
  module Oauth2
    class ClientGredential

      include Goliath::Rack::SimpleAroundware
      include Helpers::Oauth2Provider


      #4000
      class InvalidApiKeyError < Goliath::Validation::Error
        def initialize
          code = "4000"
          message = "invalid client key."
          super(code, message)
        end
      end

      def pre_process
        request = Rack::Request.new(env)
        env.logger.info "IP: #{request.ip} - REQUEST Start: #{'>'*60} Goliath ENV: #{Goliath.env}" unless request.ip == "127.0.0.1"
        env.logger.info "path info: #{env['PATH_INFO']}" unless request.ip == "127.0.0.1"
        auth_params(env) unless env['PATH_INFO'] == '/'
        env.logger.info "past api_key validation" unless request.ip == "127.0.0.1"
        Goliath::Connection::AsyncResponse
      end

      def post_process
        [status, headers, body]
      end

      # # 下面为验证签名的方法
      # def auth_params(env)
      #   env.logger.info "device model: #{get_basic_value("model", env['HTTP_AUTHORIZATION'])}, OS Version: #{get_basic_value("SystemVersion", env['HTTP_AUTHORIZATION'])}"
      #   basic_parts = get_basic_value("basic", env['HTTP_AUTHORIZATION'])
      #   key, sign_v = Base64.decode64(basic_parts).split(':')
      #   raise InvalidApiKeyError unless (key == AppConfig.client.key && sign_v == sha1_sign)
      # end
      #
      # def sha1_sign
      #   Tools::Generate.hashify("#{AppConfig.client.key}&#{AppConfig.client.secret}")
      # end


    end # Class

  end
end

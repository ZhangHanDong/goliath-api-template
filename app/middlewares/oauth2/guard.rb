require 'base64'
require 'yaml'

# Protected API
# usage:
#   use Goliath::Rack::SimpleAroundwareFactory, Middlewares::Oauth2::Guard
#
# by blackanger


module Middlewares
  module Oauth2

   class Guard
     include Goliath::Rack::SimpleAroundware
     include Helpers::Oauth2Provider

     def pre_process
      #  request = Rack::Request.new(env)
      #  skip_paths = ['/signup', '/forgot', '/login', '/users/bind', '/']
      #  env.logger.info "path info: #{env['PATH_INFO']}" unless request.ip == "127.0.0.1"
      #  guard(env) unless skip_paths.include?(env['PATH_INFO'])
       Goliath::Connection::AsyncResponse
     end

     def post_process
       [status, headers, body]
     end

     #  JWT 验证
    #  def guard(env)
    #    env.logger.info "Guard validation"
     #
    #    grant_type = get_basic_value("grant_type", env['HTTP_AUTHORIZATION'])
    #    bearer_token = rsa_decrypt(get_basic_value("bearer", env['HTTP_AUTHORIZATION']))
    #    uid = rsa_decrypt(get_basic_value("uid", env['HTTP_AUTHORIZATION']))
    #    scopes = get_basic_value("scopes", env['HTTP_AUTHORIZATION'])
    #    provider = get_basic_value("provider", env['HTTP_AUTHORIZATION'])
    #    model = get_basic_value("model", env['HTTP_AUTHORIZATION'])
    #    os_version = get_basic_value("SystemVersion", env['HTTP_AUTHORIZATION'])
     #
    #    raise ::Helpers::Errors::AuthErrors::RequiredParamsError unless (!grant_type.empty? && !bearer_token.empty? && !uid.empty? && !scopes.empty? && !provider.empty?)
    #    if grant_type == "password_gredentials"
    #      if ["local_app", "sina", "douban", "tencent", "qzone", "wxsession", "alipay"].include? provider
    #        user_token = UserToken.cache_oauth2_valid?(bearer_token.to_s, uid.to_i, provider)
    #        raise ::Helpers::Errors::AuthErrors::InvalidTokenError unless user_token
    #        raise ::Helpers::Errors::AuthErrors::AccessTokenExpiredError if UserToken.cache_token_expired?(user_token.token, expires_in: 30.minutes)
    #       #  raise ::Helpers::Errors::AuthErrors::AccessTokenExpiredError if UserToken.cache_token_expired?(user_token.token, expires_in: 30)
    #        env["user_id"] = uid
    #      else
    #        raise ::Helpers::Errors::AuthErrors::InvalidTokenError
    #      end
    #    elsif grant_type == "refresh_token"
    #      env.logger.info "Refresh token Guard validation"
    #      env["user_id"] = uid
    #      raise ::Helpers::Errors::AuthErrors::InvalidTokenError unless  ["/refresh_token"].include?(env['PATH_INFO'])
    #    else
    #      raise ::Helpers::Errors::AuthErrors::DontSupportGrantTypeError
    #    end

     end


   end # Class

  end
end

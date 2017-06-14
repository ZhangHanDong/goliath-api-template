require 'errors/auth_errors'

module Helpers
  module Oauth2Provider
    include Helpers::Errors::AuthErrors

    class InvalidApiKeyError < Goliath::Validation::BadRequestError; end

    # use: access_token, refresh_token = send_access_token(user, provider)
    def send_access_token(user, provider, device_model="", os_version="")

      user_token = UserToken.where("user_id = ? and provider = ?", user.id, provider).last

      access_token = Tools::Generate.access_token
      refresh_token = Tools::Generate.refresh_token

      period = AppConfig.access_token.expired_in.minute

      expired_at = (Time.now + period)

      if user_token && user_token.token
        user_token.token = access_token
        user_token.refresh_token = refresh_token
        user_token.expired_at = expired_at
        user_token.device_model = device_model
        user_token.os_version = os_version
        user_token.save
      else
        user_token = user.user_tokens.create(token: access_token,
                                     refresh_token: refresh_token,
                                     provider: provider,
                                     expired_at: expired_at,
                                     device_model: device_model,
                                     os_version: os_version)
      end

      return [access_token, refresh_token] if user_token
    end

    # define resource scope
    # example:
    #   oauth2_scopes :projects_index, :projects_show
    def oauth2_scopes(*scopes)
      @oauth2_scope_perms = scopes.map{|i| i.to_s}
    end

    # validate scope
    # example:
    #   get @oauth2_scope_perms when call oauth2_scopes method
    #   scope_valide(@oauth2_scope_perms, env['HTTP_AUTHORIZATION'])
    def scope_valide(perms, http_authorization)
      scopes = get_basic_value("scopes", http_authorization)
      return false unless scopes
      return true if scopes == 'all'
      return true unless (perms & scopes.split(',')).empty?
      false
    end

    def refresh_user_token(user_token, device_model="", os_version="")
      access_token = Tools::Generate.access_token
      refresh_token = Tools::Generate.refresh_token

      period = AppConfig.access_token.expired_in.minute
      expired_at = (Time.now + period)

      env.logger.info "refresh_user_token:------------------> uid: #{user_token.user_id} expired_in: #{period}"
      user_token.token = access_token
      user_token.refresh_token = refresh_token
      user_token.expired_at = expired_at
      user_token.device_model = device_model
      user_token.os_version = os_version
      user_token.save

      return [access_token, refresh_token]
    end

    # get header basic value
    # example:
    #   get_basic_value("provider", env['HTTP_AUTHORIZATION'])
    def get_basic_value(parms, http_authorization)
      basic = http_authorization
      raise InvalidApiKeyError unless basic
      parts = basic.split(/[[:blank:]]+/).last.gsub(/\n/, '')
      decode_parts = Base64.decode64(parts).split(',')
      match_parms = decode_parts.find{|s| s.match(/^#{parms}=/)}
      raise InvalidApiKeyError unless match_parms
      match_parms.split(/^#{parms}=/).last.gsub(/'/, '')
    end

    def rsa_decrypt(str)
      return str if str.blank?
      begin
        OpenSSL::PKey::RSA.new(PKCS1_PRIVATE_KEY).private_decrypt(Base64.decode64(str))
      rescue
        error!('408 Unauthorized', 408)
      end
    end

    def verify_request
      timestamp = rsa_decrypt(get_basic_value("t", env['HTTP_AUTHORIZATION']))
      time_diff = (TIMEZONE.now - TIMEZONE.parse(timestamp)).to_i
      raise ::Helpers::Errors::AuthErrors::InvalidRequestError if time_diff > 120
    end

    def verify_provider
      provider = get_basic_value("provider", env['HTTP_AUTHORIZATION'])
      if ((provider == "") || (provider.nil?))
        error!('Unauthorized', 401)
      else
        return provider
      end
    end

    def get_device_model
      get_basic_value("model", env['HTTP_AUTHORIZATION'])
    end

    def get_os_version
      get_basic_value("SystemVersion", env['HTTP_AUTHORIZATION'])
    end

    def verify_scope
      error!('401 Unauthorized', 401) unless scope_valide(@oauth2_scope_perms, env['HTTP_AUTHORIZATION'])
    end

    def verify_custom_service
      error!('401 Unauthorized', 401) unless @current_user.custom_service?
    end

  end
end

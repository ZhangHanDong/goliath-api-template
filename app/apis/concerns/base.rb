module Concerns
  module Base
    extend ActiveSupport::Concern

    included do

      # verify request. etc..
      before do
        Time.zone = "Beijing" # set time zone

        verify_request
        @provider ||= verify_provider
        @device_model ||= get_device_model
        @os_version ||= get_os_version
        @current_user ||= User.cache_find(env["user_id"]) if env["user_id"]
        @password = rsa_decrypt(params[:password]) if params[:password]
        @request = Rack::Request.new(env)

      end

      helpers ::Helpers::Oauth2Provider
      helpers ::Helpers::Jbuilder
      helpers ::Helpers::Passport
    end

  end#Base
end

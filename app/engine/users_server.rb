module Engine

  class UsersServer < Goliath::API
    # plugin Goliath::Plugin::Latency

    use Goliath::Rack::DefaultMimeType
    use Goliath::Rack::Params

    use Goliath::Rack::SimpleAroundwareFactory, Middlewares::Oauth2::ClientGredential
    use Goliath::Rack::SimpleAroundwareFactory, Middlewares::Oauth2::Guard

    # use Rack::Config do |env|
    #   env['api.tilt.root'] = "#{Goliath.root}/app/views"
    # end

    # use(Rack::Static,
    #   :root => Goliath::Application.app_path("public"),
    #   :urls => ['/uploads'])

    def response(env)
      if Goliath.env?(:production)
        ActiveRecord::Base.logger = env.logger
        ActiveRecord::Base.logger.level = 1
      end

      ::Engine::Apis::Users.call(env)
    end

  end
end

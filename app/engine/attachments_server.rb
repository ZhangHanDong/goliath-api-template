module Engine

  class AttachmentsServer < Goliath::API
    # plugin Goliath::Plugin::Latency

    use Goliath::Rack::DefaultMimeType
    use Goliath::Rack::Params

    use Goliath::Rack::SimpleAroundwareFactory, Middlewares::Oauth2::ClientGredential
    use Goliath::Rack::SimpleAroundwareFactory, Middlewares::Oauth2::Guard


    def on_headers(env, headers)
      env.logger.info 'received headers: ' + headers.inspect
    end

    def on_body(env, data)
      env.logger.info 'received data: '
      env[RACK_INPUT] << data
    end

    def on_close(env)
      env.logger.info 'closing connection'
    end

    def response(env)
      if Goliath.env?(:production)
        ActiveRecord::Base.logger = env.logger
        ActiveRecord::Base.logger.level = 2
      end
      ::Engine::Apis::Attachments.call(env)
    end

  end
end

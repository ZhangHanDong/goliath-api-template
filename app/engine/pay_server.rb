module Engine

  class PayServer < Goliath::API
    # plugin Goliath::Plugin::Latency

    def response(env)
      if Goliath.env?(:production)
        ActiveRecord::Base.logger = env.logger
        ActiveRecord::Base.logger.level = 2
      end
      ::Engine::Apis::Pay.call(env)
    end

  end
end

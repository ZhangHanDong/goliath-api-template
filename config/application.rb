$: << "../../config" << "./config"

require 'boot'
require 'core'

case Goliath.env
when :production
  logger = Logger.new("log/production_sql.log")
  logger.level = Logger::INFO
else
  logger = Logger.new("log/development_sql.log")
  logger.level = Logger::DEBUG
end

ActiveRecord::Base.logger = logger

# encode

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

Grape::Endpoint.send :include, ActiveSupport::NumberHelper
Grape::Endpoint.send :include, Tools::NumberHelper
Grape::Endpoint.send :include, Tools::JsonCache

#set json engine
MultiJson.engine = :oj

# set server port
ATTACHMENTS_SERVER_PORTS=[6000, 6001]
PAY_SERVER_PORTS=[8000, 8001]
USERS_SERVER_PORTS=[9000, 9001, 9002, 9003]



# hack for sync www
class Rails
  def self.cache
    ::MemcachedClient
  end

  def self.root
    ::Goliath.root
  end

  def self.env
    self
  end

  def self.production?
    Goliath.env?(:production)
  end

end

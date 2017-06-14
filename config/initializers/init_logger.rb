# # Initialize logger
# require 'logger'
# class ::Logger; alias_method :write, :<<; end
#
# if Goliath.env?(:production)
#   logger.level = ::Logger::WARN
# else
#   logger = ::Logger.new(STDOUT)
#   logger.level = ::Logger::DEBUG
# end
#
#
# # Customize goliath request log
# Goliath::Request.log_block = lambda do |env, response, elapsed_time|
#   method = env[Goliath::Request::REQUEST_METHOD]
#   path   = env[Goliath::Request::REQUEST_URI]
#
#   env[Goliath::Request::RACK_LOGGER].info("#{response.status} #{method} #{path} in #{'%.2f' % elapsed_time} ms")
# end

# # ActiveJob::Base.queue_adapter = :sidekiq
# # GlobalID.app = 'MobileApi'
# #
# #
# ###### sidekiq config
# redis_server = '127.0.0.1' # redis服务器
# redis_port = 6379 # redis端口
# redis_db_num = 0 # redis 数据库序号
# redis_namespace = 'mobile-api' #命名空间，自定义的
#
# Sidekiq.configure_server do |config|
#   config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace, password: 'demo' }
# end
#
# Sidekiq.configure_client do |config|
#   config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace, password: 'demo' }
# end
# #
# # ###### delayed jobs config
# # #
# # # Delayed::Worker.destroy_failed_jobs = false
# # # Delayed::Worker.sleep_delay = 60
# # # Delayed::Worker.max_attempts = 1
# # # Delayed::Worker.max_run_time = 24.hour
# # # Delayed::Worker.default_queue_name = 'default'

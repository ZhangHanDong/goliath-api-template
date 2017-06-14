puts "redis connect..."
REDIS_CONFIG = YAML.load_file(Goliath.root + '/config/redis.yml')[Goliath.env.to_s]
SENTINELS = [{:host => REDIS_CONFIG["host"], :port => REDIS_CONFIG["port"]}]

redis_connection = Redis.new(:url => REDIS_CONFIG["url"], :sentinels => SENTINELS, :role => :master, :password => REDIS_CONFIG["password"])
# redis_connection = Redis.new(:url => REDIS_CONFIG["url"], :sentinels => SENTINELS, :role => :master, :password => REDIS_CONFIG["password"], :driver => :synchrony)
# resque_redis_connection = Redis.new(:url => REDIS_CONFIG["url"], :sentinels => SENTINELS, :role => :master, :password => REDIS_CONFIG["password"], :driver => :hiredis)

REDIS = Redis::Namespace.new(:demo, :redis => redis_connection)
# RESQUE_REDIS = Redis::Namespace.new(:demo, :redis => resque_redis_connection)

Redis.current = REDIS
Resque.redis = REDIS

$: << "../../config" << "./config"

# Resque 配置，支持sentinel
CONFIG_PATH = File.expand_path("..", __FILE__)
REDIS_CONFIG = YAML.load_file(File.join(CONFIG_PATH, 'redis.yml'))[ENV['RACK_ENV']]
SENTINELS = [{:host => REDIS_CONFIG["host"], :port => REDIS_CONFIG["port"]}]

redis_connection = Redis.new(:url => REDIS_CONFIG["url"], :sentinels => SENTINELS, :role => :master, :password => REDIS_CONFIG["password"])
# redis_connection = Redis.new(:url => REDIS_CONFIG["url"], :sentinels => SENTINELS, :role => :master, :password => REDIS_CONFIG["password"], :driver => :synchrony)

REDIS = Redis::Namespace.new(:demo, :redis => redis_connection)

Redis.current = REDIS
Resque.redis = REDIS

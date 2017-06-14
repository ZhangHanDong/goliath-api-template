puts "connect memcached..."
MEM_CONFIG = YAML.load_file(Goliath.root + '/config/memcached.yml')[Goliath.env.to_s]

MemcachedClient = EM::Synchrony::ConnectionPool.new(size: 20) do
  ActiveSupport::Cache::MemCacheStore.new(MEM_CONFIG["servers"], async: true)
end

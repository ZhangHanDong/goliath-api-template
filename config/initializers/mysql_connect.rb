# # 用于在本地测试远程mysql
# require 'em-synchrony/activerecord'
#
# puts "connect mysql..."
# DB_CONFIG = YAML.load_file(Goliath.root + '/config/database.yml')[Goliath.env.to_s]
#
# # Use only local
# def connect_remote_mysql
#   require 'net/ssh/gateway'
#   remote_port = 3307
#   begin
#     config = YAML.load_file(Goliath.root + '/config/secrets.yml')[Goliath.env.to_s]
#     gateway = Net::SSH::Gateway.new(config["server"]["host"],
#                                     config["server"]["user"],
#                                    {:port => config["server"]["port"],
#                                     :password => config["server"]["password"]})
#     port = gateway.open('127.0.0.1', 3306, remote_port)
#     puts "connect port: #{port.inspect}"
#     DB_CONFIG.merge!("port" => port)
#
#   rescue
#     remote_port += 1
#
#     retry if remote_port <= 3310
#     puts "remote_port: #{remote_port}"
#     exit -1
#   end
# end
#
# connect_remote_mysql if Goliath.env?(:development)
# ActiveRecord::Base.establish_connection DB_CONFIG
# # ActiveRecord::Base.raise_in_transactional_callbacks = true #activerecord 4.2
# # ActiveRecord::Base.send :include, GlobalID::Identification # activejob -> 4.2

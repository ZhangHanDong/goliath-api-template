require "thor"
require "active_support/inflector"

module Command
  class Cli < Thor
    include Thor::Actions
    source_root File.dirname(__FILE__)

    ## start console
    ## ./bin/goliath c
    desc "c", "start console"
    method_option :environment, :aliases => "-e", :desc => "server environment"
    def c
      load_applicaiton
      say "Mobile Api Application Console start with Goliath : #{::Goliath.env}", :green

      ActiveRecord::Base.logger = Logger.new(STDOUT)
      Pry.start
      exit
    end

    ## start console
    ## ./bin/goliath console
    desc "console", "start console"
    method_option :environment, :aliases => "-e", :desc => "server environment"
    alias_method :console, :c

    ## start server
    ## ./bin/goliath s
    ## ./bin/goliath s -e production
    desc "s [options]", "start goliath server"
    method_option :environment, :aliases => "-e", :desc => "server environment"
    method_option :server, :aliases => "-s", :desc => "server name"
    def s
      load_applicaiton
      env = "#{options[:environment] || 'development' }"
      commands = []

      if options[:server]
        case options[:server]
        when "attachments"
          ::ATTACHMENTS_SERVER_PORTS.each do |port|
            command = command('attachments', port, env)
            commands << command
          end
        when "users"
          ::USERS_SERVER_PORTS.each do |port|
            command = command('users', port, env)
            commands << command
          end
        when "pay"
          ::PAY_SERVER_PORTS.each do |port|
            command = command('pay', port, env)
            commands << command
          end
        end
      else
        ::ATTACHMENTS_SERVER_PORTS.each do |port|
          command = command('attachments', port, env)
          commands << command
        end

        ::USERS_SERVER_PORTS.each do |port|
          command = command('users', port, env)
          commands << command
        end

        ::PAY_SERVER_PORTS.each do |port|
          command = command('pay', port, env)
          commands << command
        end
      end

      commands.each do |command|
        say "run command: #{command}", :yellow
        %x|  #{command} |
      end
      exec 'exit'
    end

    ## start server
    ## ./bin/goliath start
    ## ./bin/goliath start -e production
    desc "start [options]", "start goliath server"
    method_option :environment, :aliases => "-e", :desc => "server environment"
    method_option :server, :aliases => "-s", :desc => "server name"
    alias_method :start, :s

    ## stop server
    ## ./bin/goliath stop
    desc 'stop', "stop goliath server"
    def stop
      say "Goliath shutdown ing...", :red

      pids = Dir.glob("#{root}/tmp/*.pid").inject([]) do |pids, pid_file|
        pids << %x|cat #{pid_file}|
      end

      pids.each do |pid|
        puts "--- pid: #{pid.to_i}"
        %x|kill -QUIT #{pid.to_i}|
      end
    end

    ## start database console
    ## ./bin/goliath db
    desc "db", "restart db console"
    method_option :environment, :aliases => "-e", :desc => "server environment"
    method_option :password, :aliases => "-p", :desc => "Automatically provide the password from database.yml"
    def db
      load_applicaiton
      say "Goliath db cosole...", :yellow
      case DB_CONFIG["adapter"]
      when /mysql/
        args = {
          'host'      => '--host',
          'port'      => '--port',
          'socket'    => '--socket',
          'username'  => '--user',
          'encoding'  => '--default-character-set',
          'sslca'     => '--ssl-ca',
          'sslcert'   => '--ssl-cert',
          'sslcapath' => '--ssl-capath',
          'sslcipher' => '--ssh-cipher',
          'sslkey'    => '--ssl-key'
        }.map { |opt, arg| "#{arg}=#{DB_CONFIG[opt]}" if DB_CONFIG[opt] }.compact
      end
      if DB_CONFIG['password'] && options['password']
        args << "--password=#{DB_CONFIG['password']}"
      elsif DB_CONFIG['password'] && !DB_CONFIG['password'].to_s.empty?
        args << "-p"
      end

      args << DB_CONFIG['database']

      command = "mysql #{args.join(' ')}"

      exec command

    end


    ## start database console
    ## ./bin/goliath db
    desc "dbconsole", "restart db console"
    method_option :environment, :aliases => "-e", :desc => "server environment"
    method_option :password, :aliases => "-p", :desc => "Automatically provide the password from database.yml"
    alias_method :dbconsole, :db

    private

      def root
        ::File.expand_path('../../../', __FILE__)
      end

      def load_applicaiton
        require "bundler/setup"
        Bundler.require :default
        $: << "../../config" << "./config"

        ENV['RACK_ENV'] = options[:environment] || "development"

        require "application"
      end

      def command(server_name, port, environment)
        load_applicaiton

        "ruby #{Goliath.root}/servers/#{server_name}.rb -sv -e #{environment} -p #{port} -l #{Goliath.root}/log/api_#{port}.log -P #{Goliath.root}/tmp/#{server_name}_#{port}_goliath.pid -d"
      end

  end
end

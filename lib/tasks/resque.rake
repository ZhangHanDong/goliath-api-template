# bundle exec rake resque:workers COUNT=2 RESQUE_WORKER=true QUEUE=* BACKGROUND=yes TERM_CHILD=1 RACK_ENV=production
require 'resque/tasks'

namespace :resque do
  task :setup do
    raise "Please set your RESQUE_WORKER variable to true" unless ENV['RESQUE_WORKER'] == "true"
    require "#{app_root}/config/application"

    logfile = File.open("#{app_root}/log/resque.log", 'a')

    Resque.logger = Logger.new logfile
    Resque.logger.level = Logger::DEBUG
    # Activate file synchronization
    logfile.sync = true

    # Resque.before_fork = Proc.new {
    #   # ActiveRecord::Base.establish_connection
    #
    #   # Open the new separate log file
    #
    # }
  end


  desc "Start resque worker"
  task :start_workers do
    ENV['COUNT'] = '2'
    ENV['RESQUE_WORKER'] = 'true'
    ENV['QUEUE'] = '*'
    ENV['BACKGROUND'] = 'yes'
    ENV['TERM_CHILD'] = '1'
    ENV['RACK_ENV'] = "production"
    Rake::Task["resque:workers"].invoke
  end

  desc "Quit running workers"
  task :stop_workers do
    pids = %x|pgrep -f resque|.split
    if pids.empty?
      puts "No workers to kill"
    else
      pids.each do |pid|
        %x|kill -9 #{pid}|
      end
    end
  end


  private

  def app_root
    ::File.expand_path('../../../', __FILE__)
  end

end

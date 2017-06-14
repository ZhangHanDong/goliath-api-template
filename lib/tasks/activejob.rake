require 'fileutils'

namespace :job do

  desc "Restart sidekiq servers. Just for production env."
  task :sidekiq_restart, :env do
    Rake::Task['job:sidekiq_stop'].invoke
    Rake::Task["job:sidekiq_start[#{env}]"].invoke
  end

  desc "Shutdown sidekiq  servers. Just for production env."
  task :sidekiq_stop do
    stop_sidekiq
  end

  desc "Start sidekiq servers. Just for production env."
  task :sidekiq_start, :env do |t, args|
    run_sidekiq("#{args[:env]}")
  end

  # desc "start sidekiq web server"
  # task :sidekiq_web, :env do |t, args|
  #   run_sidekiqweb("#{args[:env]}")
  # end


  private

  # stop_sidekiq
  def stop_sidekiq
    # %x{ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9}
    %x{sidekiqctl stop #{app_root}/tmp/sidekiq/sidekiq.pid 60}
  end

  # Start sidekiq
  # bundle exec rake job:sidekiq_start[development]
  def run_sidekiq(env)
    sidekiq_dir = "#{app_root}/config/activejob/sidekiq"
    %x|bundle exec sidekiq -vr #{sidekiq_dir}/sidekiq.rb -d -e "#{env}" -L log/sidekiq.log -C #{sidekiq_dir}/sidekiq.yml|
  end

  # start sidekiq webui
  # def run_sidekiqweb(env)
  #   sidekiq_dir = "#{app_root}/config/activejob/sidekiq"
  #   %x|RACK_ENV=#{env} rackup #{sidekiq_dir}/webui.ru -D|
  # end

  def app_root
    ::File.expand_path('../../../', __FILE__)
  end



end

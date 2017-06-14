require 'fileutils'

namespace :server do

  desc "Restart goliath servers. Just for production env."
  task :restart do
    Rake::Task['server:stop'].invoke
    Rake::Task['server:start'].invoke
  end

  desc "Shutdown goliath  servers. Just for production env."
  task :stop do
    stop_workers
  end

  desc "Start goliath servers. Just for production env."
  task :start, :server_name do |t, args|
    run_worker("#{args[:server_name]}")
  end

  def stop_workers
    %x| #{app_root}/bin/goliath stop|
  end



  # Start a worker with proper env vars and output redirection
  def run_worker(server_name)
    if !server_name.empty?
      %x| #{app_root}/bin/goliath s -e production -s #{server_name}|
    else
      %x| #{app_root}/bin/goliath s -e production|
    end
  end

  def app_root
    ::File.expand_path('../../../', __FILE__)
  end



end

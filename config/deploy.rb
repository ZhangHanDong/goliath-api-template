# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'mobile-api'
set :repo_url, ''

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, ''
# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/memcached.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{log public tmp config/demo/pems}

# Default value for default_env is {}
set :default_env, { path: "/usr/local/ruby/bin:$PATH" }
# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc "Restart Goliath server"
  task :restart_workers do
    on roles(:app, :nf), in: :groups, limit: 3, wait: 10 do
      within current_path do
        execute :sudo, "service monit stop"
        execute "cd #{current_path} && rake server:restart"
        execute :sudo, "service monit start"
      end
    end
  end

  desc "restart resque server"
  task :restart_resque do
    on roles(:nf), in: :groups, limit: 3, wait: 10 do
      within current_path do
        execute "cd #{current_path} && bundle exec rake resque:stop_workers"
        execute "cd #{current_path} && bundle exec rake resque:start_workers"
      end
    end
  end

  task :bundle_install do
    on roles(:app, :nf) do
      execute "cd #{current_path} && bundle install --without development test"
    end
  end


  before :restart_workers, :bundle_install
  after :publishing, :restart_workers
  after :restart_workers, :restart_resque


end

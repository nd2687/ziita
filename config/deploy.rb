# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'ziita'
set :repo_url, 'git@bitbucket.org:totoman/ziita.git'
set :log_level, :debug
set :keep_releases, 3
set :linked_files, %w{ config/database.yml config/secrets.yml }
set :linked_dirs, %w{
  log tmp/pids tmp/cache tmp/sockets config/unicorn
  vendor/bundle vendor/assets/bower_components public/system public/fonts
}

#set :port, 22
#set :deploy_via, :remote_cache
#set :use_sudo, false

set :pty, true
set :migration_role, 'migrator'
set :conditionaly_migrate, true
# set :maintenance_template_path, 'app/views/system/maintenance.html.erb'

namespace :deploy do

  desc 'Install assets with Bower'
  task :bower do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'bower:install'
        end
      end
    end
  end

  before 'assets:precompile', :bower

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart

  desc 'Stop and restart application'
  task :stop_and_restart do
    on roles(:app), in: :sequence, wait: 5 do
    # invoke 'maintenance:enable'
      invoke 'unicorn:stop'
      sleep(5)
      invoke 'unicorn:restart'
    # invoke 'maintenance:disable'
    end
  end

  desc 'deploy with enabling maintenance page'
  task :upgrade do
    on roles(:app, :db), in: :sequence, wait: 5 do
    # invoke 'maintenance:enable'
      invoke 'deploy'
    # invoke 'maintenance:disable'
    end
  end

end

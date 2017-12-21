# coding: utf-8
# config valid only for current version of Capistrano
#lock "3.9.0"

# slack
require 'slack-notifier'
set :slack_team, ""
set :slack_webhook_url, ""
set :slack_channel, '#dev-ops'
set :slack_username, 'Slack notifier'

set :application, 'sindan_visualization'

set :repo_url, 'git@bitbucket.org:sindan/sindan_visualization.git'
set :branch, :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :user, 'deploy'
set :deploy_to, '/var/www/sindan-production'

# Set the ruby version
set :rbenv_type, :system
set :rbenv_ruby, '2.4.1'

# server alias
set :sindan, ""
set :sindandev, ""
set :vagrant, '127.0.0.1'

# Default value for :format is :airbrussh.
set :format, :airbrussh

# Default value for :log_level is :debug
set :log_level, :debug # :debug or :info

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :ssh_options, {
  keys: [File.expand_path('~/.ssh/id_rsa')],
  forward_agent: true,
  auth_methods: %w(publickey)
}

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'upload important files'
  task :config do
    on roles(:app) do |host|
      upload!('config/secrets.yml',"#{shared_path}/config/secrets.yml")
    end
  end
end

namespace :db do

  # linked_filesで使用するファイルをアップロードする
  desc 'upload important files'
  task :config do
    on roles(:app) do |host|
      upload!('config/database.yml',"#{shared_path}/config/database.yml")
    end
  end

  after 'deploy:config', 'db:config'

  desc 'reset databse'
  task :reset do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:migrate:reset"
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc 'add seed data'
  task :seed do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc 'display a list of pending migrations'
  task :pending_migrations do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:abort_if_pending_migrations"
        end
      end
    end
  end
end

namespace :log do

  desc "tail -f accees_log"
  task :tail do
    on roles(:web) do
      env = fetch(:rails_env)
      env = 'develoment' if env == 'staging'
      execute "tail -f #{shared_path}/log/#{env}.log"
    end
  end
end

namespace :slack_notify do

  notifier = Slack::Notifier.new fetch(:slack_webhook_url), channel: fetch(:slack_channel), username: fetch(:slack_username)

  desc 'notify start deploy for slack'
  task :deploy_started do
    notifier.ping "#{ENV['USER'] || ENV['USERNAME']} started deploying branch #{fetch :application}/#{fetch :branch} to #{fetch :stage} (#{fetch :rails_env, 'production'})."
  end

  desc 'notify finish deploy for slack'
  task :deploy_finished do
    notifier.ping "#{ENV['USER'] || ENV['USERNAME']} finished deploying branch #{fetch :application}/#{fetch :branch} to #{fetch :stage} (#{fetch :rails_env, 'production'})."
  end

  desc 'notify fail deploy for slack'
  task :deploy_failed do
    notifier.ping "*ERROR!* #{ENV['USER'] || ENV['USERNAME']} failed to deploy branch #{fetch :application}/#{fetch :branch} to #{fetch :stage} (#{fetch :rails_env, 'production'})."
  end

  before 'deploy:starting', 'slack_notify:deploy_started'
  after :deploy, 'slack_notify:deploy_finished'
  before 'deploy:finishing_rollback', 'slack_notify:deploy_failed'
end

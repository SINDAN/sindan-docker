set :stage, :development

set :branch, 'develop'
set :deploy_to, '/var/www/sindan-staging'
set :rails_env, 'development'
set :migration_role, 'db'

server fetch(:vagrant), user: fetch(:user), roles: %w{web app db}, ssh_options: {
         port: 2222
       }

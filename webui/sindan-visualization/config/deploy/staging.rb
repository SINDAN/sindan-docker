set :stage, :staging

set :branch, 'develop'
set :deploy_to, '/var/www/sindan-staging'
set :rails_env, 'development'
set :migration_role, 'db'

server fetch(:sindandev), user: fetch(:user), roles: %w{web app db}

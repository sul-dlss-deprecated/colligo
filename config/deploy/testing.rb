set :stage, :testing
set :repo_url, 'https://github.com/anusharanganathan/colligo.git'
set :branch, 'dev'
set :deploy_host, ask('Server', 'e.g. server.stanford.edu')
set :linked_files, fetch(:linked_files, []).push('config/blacklight.yml', 'config/jetty.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('db', 'jetty')
set :keep_releases, 3

server fetch(:deploy_host), user: fetch(:user), roles: %w(web db app)

set :rails_env, :development

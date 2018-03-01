set :application, 'colligo'
set :repo_url, 'https://github.com/sul-dlss/colligo.git'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for keep_releases is 5
set :keep_releases, 5

# all servers (even -dev) will be rails_env production
set :rails_env, 'production'
set :puma_bind, %w(tcp://127.0.0.1:3000)
after 'deploy:finished', 'puma:restart'

ask(:user, 'deploy_user')
ask(:server_name, 'server_name')
ask(:port, 'ssh_port')

set :home_directory, "/home/#{fetch(:user)}"
set :deploy_to, "#{fetch(:home_directory)}/#{fetch(:application)}"

server fetch(:server_name), user: fetch(:user), roles: %w(web db app), port: fetch(:port)
set :bundle_without, %w(test deployment development).join(' ')

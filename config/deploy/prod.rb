# server uses standardized suffix
server 'sul-dms-discovery-prod.stanford.edu', user: fetch(:user), roles: %w{web db app}
set :bundle_without, %w(test deployment development).join(' ')

Capistrano::OneTimeKey.generate_one_time_key!

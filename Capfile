# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/bundler'
require 'dlss/capistrano'
require 'capistrano/passenger'
require 'capistrano/rvm'
require 'capistrano/rails'
require 'capistrano/scm/git'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

install_plugin Capistrano::SCM::Git

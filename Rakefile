# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
task default: [:ci]
require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

ZIP_URL = 'https://github.com/projectblacklight/blacklight-jetty/archive/v4.10.3.zip'
require 'jettywrapper'

desc 'Execute the test build that runs on travis'
task ci: [:environment] do
  if Rails.env.test?
    Rake::Task['db:migrate'].invoke
    Rake::Task['jetty:download'].invoke
    Rake::Task['jetty:unzip'].invoke
    Rake::Task['colligo:copy_solr_configs'].invoke
    Jettywrapper.wrap(Jettywrapper.load_config) do
      Rake::Task['spec'].invoke
    end
  else
    system('RAILS_ENV=test rake ci')
  end
end

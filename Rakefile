# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
task default: [:ci]
require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc 'Execute the test build that runs on travis'
task ci: [:environment] do
  if Rails.env.test?
    SolrWrapper.wrap(port: '8983') do |solr|
      solr.with_collection(name: 'blacklight-core', dir: File.join(File.expand_path(File.dirname(__FILE__)), 'config', 'solr_configs')) do
        Rake::Task['db:migrate'].invoke
        WebMock.allow_net_connect!
        Rake::Task['colligo:fixtures'].invoke
        Rake::Task['spec'].invoke
      end
    end
  else
    system('RAILS_ENV=test rake ci')
  end
end

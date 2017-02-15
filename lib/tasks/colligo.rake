require 'data_indexer'
namespace :colligo do
  desc 'Run Solr and Colligo application for development'
  task :server, [:rails_server_args] do |_t, args|
    require 'solr_wrapper'
    SolrWrapper.wrap(port: '8983') do |solr|
      solr.with_collection(name: 'blacklight-core', dir: File.join(File.expand_path('../..', File.dirname(__FILE__)), 'config', 'solr_configs')) do
        Rake::Task['colligo:fixtures'].invoke
        system "bundle exec rails s #{args[:rails_server_args]}"
      end
    end
  end
  desc 'Index test fixtures'
  task fixtures: [:environment] do
    DataIndexer.new('Test collection', 'data/test_manifest_urls.csv').run
  end
end

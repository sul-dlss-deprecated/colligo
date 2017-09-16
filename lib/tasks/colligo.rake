require 'data_indexer'
require 'vatican_data_indexer'
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
  desc 'Index Pathway A'
  task pathway_a: [:environment] do
    VaticanDataIndexer.new('Pathway A', 'data/pathway_a.csv').run
    Rails.logger.level = Logger::DEBUG
    Rails.logger = Logger.new(STDOUT)
  end
  desc 'Index Pathway B'
  task pathway_b: [:environment] do
    VaticanDataIndexer.new('Pathway B', 'data/pathway_b.csv').run
  end
  desc 'Index Pathway C'
  task pathway_c: [:environment] do
    VaticanDataIndexer.new('Pathway C', 'data/pathway_c.csv').run
  end
  desc 'Index Pathway D'
  task pathway_d: [:environment] do
    VaticanDataIndexer.new('Pathway D', 'data/pathway_d.csv').run
  end
end

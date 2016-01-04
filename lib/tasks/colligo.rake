require 'jettywrapper'
namespace :colligo do
  desc 'Run Colligo local installation steps'
  task install: [:environment] do
    Rake::Task['db:migrate'].invoke
    Rake::Task['colligo:download_and_unzip_jetty'].invoke
    Rake::Task['colligo:copy_solr_configs'].invoke
  end
  desc 'Download and unzip jetty'
  task :download_and_unzip_jetty do
    unless File.exist?("#{Rails.root}/jetty")
      puts 'Downloading jetty'
      Rake::Task['jetty:download'].invoke
      puts 'Unzipping jetty'
      Rake::Task['jetty:unzip'].invoke
    end
  end
  desc 'Copy solr configs'
  task :copy_solr_configs do
    %w(schema solrconfig).each do |file|
      cp "#{Rails.root}/config/solr_configs/#{file}.xml", "#{Rails.root}/jetty/solr/blacklight-core/conf/"
    end
  end
end

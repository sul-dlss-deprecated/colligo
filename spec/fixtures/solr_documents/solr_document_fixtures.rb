# encoding: UTF-8
require 'json'
module SolrDocumentFixtures
  def manuscript_resp_001
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/manuscript_solr_resp_001.json").read)
  end
end

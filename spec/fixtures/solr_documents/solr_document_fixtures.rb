# encoding: UTF-8
require 'json'
module SolrDocumentFixtures
  def annotation_resp
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/annotation_solr_resp.json").read)
  end

  def annotation_docs
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/annotation_solr_doc.json").read)
  end

  def transcription_resp
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/transcription_solr_resp.json").read)
  end

  def transcription_docs
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/transcription_solr_doc.json").read)
  end

  def manuscript_resp
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/manuscript_solr_resp.json").read)
  end

  def manuscript_docs
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/manuscript_solr_doc.json").read)
  end

  def annotation_resp_002
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/annotation_solr_resp_002.json").read)
  end

  def annotation_docs_002
    []
  end

  def transcription_resp_002
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/transcription_solr_resp_002.json").read)
  end

  def transcription_docs_002
    []
  end

  def manuscript_resp_002
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/manuscript_solr_resp_002.json").read)
  end

  def manuscript_docs_002
    []
  end

  def annotation_resp_003
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/annotation_solr_resp_003.json").read)
  end

  def annotation_docs_003
    []
  end

  def transcription_resp_003
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/transcription_solr_resp_003.json").read)
  end

  def transcription_docs_003
    ans = transcription_resp_003
    ans['response']['docs']
  end

  def manuscript_resp_003
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/manuscript_solr_resp_003.json").read)
  end

  def manuscript_docs_003
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/manuscript_solr_doc_003.json").read)
  end

  def related_annotations
    {
      'hp146pz7537' => 10,
      'wz353pg0755' => 320,
      'xs067jx3704' => 0,
      'pc969nh5331' => 100,
      'kx761rc2825' => 4,
      'tz740cf3316' => 0,
      'rr549ng6599' => 43,
      'ct437ht0445' => 30,
      'yq907xc9138' => 108,
      'ds092yq5452' => 123
    }
  end

  def related_transcriptions
    {
      'hp146pz7537' => 0,
      'wz353pg0755' => 32,
      'xs067jx3704' => 10,
      'pc969nh5331' => 140,
      'kx761rc2825' => 41,
      'tz740cf3316' => 0,
      'rr549ng6599' => 52,
      'ct437ht0445' => 35,
      'yq907xc9138' => 101,
      'ds092yq5452' => 345
    }
  end

  def prev_and_next_docs
    JSON.parse(File.open("#{::Rails.root}/spec/fixtures/solr_documents/prev_and_next_docs.json").read)
  end
end

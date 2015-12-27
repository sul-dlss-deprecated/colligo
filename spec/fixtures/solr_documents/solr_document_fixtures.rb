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

  def related_annotations
    {
      'Gospel Lectionary' => 10,
      'Greek Gospel Lectionary (fragments)' => 320,
      'Walters Ms. W.528, Gospel Book' => 0,
      'Walters Ms. W.520, Gospel Lectionary' => 100,
      'Walters Ms. W.751, Corvey Gospel fragment' => 4,
      'Walters Ms. W.527, Gospel Book' => 0,
      'Walters Ms. W.529, Gospel Book' => 43,
      'Walters Ms. W.523, Gospel Book' => 30,
      'Walters Ms. W.522, Gospel Book' => 108,
      'Walters Ms. W.524, Gospel Book' => 123
    }
  end

  def related_transcriptions
    {
      'Gospel Lectionary' => 0,
      'Greek Gospel Lectionary (fragments)' => 32,
      'Walters Ms. W.528, Gospel Book' => 10,
      'Walters Ms. W.520, Gospel Lectionary' => 140,
      'Walters Ms. W.751, Corvey Gospel fragment' => 41,
      'Walters Ms. W.527, Gospel Book' => 0,
      'Walters Ms. W.529, Gospel Book' => 52,
      'Walters Ms. W.523, Gospel Book' => 35,
      'Walters Ms. W.522, Gospel Book' => 101,
      'Walters Ms. W.524, Gospel Book' => 345
    }
  end
end
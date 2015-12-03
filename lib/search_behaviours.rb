module Colligo::SearchBehaviors
  extend ActiveSupport::Concern

  def add_manuscript_filter(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << ('model:Manuscript')
  end

  def add_annotation_filter(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << ('model:Annotation')
  end

  def add_transcription_filter(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << ('model:Transcription')
  end
end

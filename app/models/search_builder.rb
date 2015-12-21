class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior

  def add_manuscript_filter(solr_parameters)
    solr_parameters[:qt] = 'descriptions'
  end

  def add_annotation_filter(solr_parameters)
    solr_parameters[:qt] = 'annotations'
  end

  def add_transcription_filter(solr_parameters)
    solr_parameters[:qt] = 'transcriptions'
  end
end

# Solr query filters based on content type
# These can be added to the solr query to restrict queries by content type
class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior

  # restrict solr to content type 'descriptions' (mods)
  def add_manuscript_filter(solr_parameters)
    solr_parameters[:qt] = 'descriptions'
  end

  # restrict solr to content type 'annotations'
  def add_annotation_filter(solr_parameters)
    solr_parameters[:qt] = 'annotations'
  end

  # restrict solr to content type 'transcriptions'
  def add_transcription_filter(solr_parameters)
    solr_parameters[:qt] = 'transcriptions'
  end

  # restrict solr to content type 'search' which combine them all
  def all_search_filter(solr_parameters)
    solr_parameters[:qt] = 'search'
  end
end

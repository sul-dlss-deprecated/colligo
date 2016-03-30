class ManuscriptController < ApplicationController
  include Blacklight::Configurable
  include Blacklight::SolrHelper
  include Blacklight::Catalog::SearchContext
  copy_blacklight_config_from(CatalogController)

  layout 'blacklight'

  def show
    @response, @document = get_solr_response_for_doc_id params[:id]
    # Sanitize results for the viewer
    sd = SolrDocument.new
    @document.each do |k, v|
      @document[k] = [] if v.blank? && !sd.single_valued_display_fields.include?(k)
    end
    sd.all_display_fields.each do |k|
      unless @document.include?(k)
        @document[k] = [] unless sd.single_valued_display_fields.include?(k)
      end
    end
    # Get the contents from the manifest - need this for getting first folio
    # TODO: Index manifest and use that to retrieve the details
    @contents = []
    @contents = IiifManifest.new(@document['manifest_urls'].first).contents unless @document['manifest_urls'].blank?
    # Get related annotations and transcriptions
    @related_annotations = related_annotations[0]
    @related_transcriptions = related_transcriptions[0]
    # Get the next and previous docs
    m_previous_and_next_documents
    respond_to do |format|
      format.html do
        render
      end
    end
  end

  def related_content
    transcriptions = related_transcriptions
    ans = {
        annotations: related_annotations,
        transcriptions: transcriptions[0],
        first_transcription: transcriptions[1]
    }
    respond_to do |format|
      format.json do
        render json: ans
      end
    end
  end

  private

  def related_annotations
    if params.has_key?(:folio) && params[:folio].present?
      query_params = { q: "druid:#{params[:id]} AND folio:\"#{params[:folio]}\"", rows: 0 }
    else
      query_params = { q: "druid:#{params[:id]}", rows: 0 }
    end
    search_params_logic = self.search_params_logic + [:add_annotation_filter] - [:all_search_filter, :add_manuscript_filter, :add_transcription_filter]
    (resp, _doc_list) = search_results(query_params, search_params_logic)
    resp['response']['numFound']
  end

  def related_transcriptions
    if params.has_key?(:folio) && params[:folio].present?
      query_params = { q: "druid:#{params[:id]} AND folio:\"#{params[:folio]}\"", rows: 1, sort: 'sort_index asc' }
    else
      query_params = { q: "druid:#{params[:id]}", rows: 1, sort: 'sort_index asc' }
    end
    search_params_logic = self.search_params_logic + [:add_transcription_filter] -[:all_search_filter, :add_manuscript_filter, :add_annotation_filter]
    (resp, doc_list) = search_results(query_params, search_params_logic)
    if doc_list.present?
      [resp['response']['numFound'], doc_list[0]['body_chars_display']]
    else
      [resp['response']['numFound'], nil]
    end
  end

  def m_previous_and_next_documents
    m_params = current_query
    @prev_doc = {}
    @next_doc = {}
    return if m_params.blank? || m_params[:start].blank?
    nav_docs = get_previous_and_next_documents_for_search(m_params[:start], m_params, {})
    if nav_docs.second && nav_docs.second.first.present? && m_params[:start] > 0
      index = m_params[:start] - 1
      @prev_doc['path'] = url_for(controller: 'manuscript', action: 'show', id: nav_docs.second.first['druid'], params: {start: index})
      @prev_doc['title'] = nav_docs.second.first['title_display'] || nav_docs.second.first['druid']
    end
    if nav_docs.second && nav_docs.second.second.present? && m_params[:start] < nav_docs.first['response']['numFound'] - 1
      index = m_params[:start] + 1
      @next_doc['path'] = url_for(controller: 'manuscript', action: 'show', id: nav_docs.second.second['druid'], params: {start: index})
      @next_doc['title'] = nav_docs.second.second['title_display'] || nav_docs.second.second['druid']
    end
  end

  def current_query
    return nil if session[:m_last_search_query].blank? || !params.has_key?(:start) || params[:start].blank?
    m_params = JSON.parse(session[:m_last_search_query])
    begin
      m_params['start'] = Integer(params[:start])
    rescue
      return nil
    end
    m_params['qt'] = 'descriptions'
    m_params.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end
end

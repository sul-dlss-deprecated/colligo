class ManuscriptController < ApplicationController
  include Blacklight::Configurable
  include Blacklight::SolrHelper
  include Blacklight::Catalog::SearchContext
  copy_blacklight_config_from(CatalogController)

  layout 'blacklight'

  def show
    m_params = current_query
    redirect_to(action: 'show', id: params[:id] ) and return if params.has_key?(:start)
    @sd = SolrDocument.new
    @response, @document = get_solr_response_for_doc_id params[:id]
    # Sanitize results for the viewer
    @document.each do |k, v|
      @document[k] = [] if v.blank? && !@sd.single_valued_display_fields.include?(k)
    end
    @sd.all_display_fields.each do |k|
      unless @document.include?(k)
        @document[k] = [] unless @sd.single_valued_display_fields.include?(k)
      end
    end
    # Get the contents from the manifest
    @contents = []
    @contents = IiifManifest.new(@document['manifest_urls'].first).contents unless @document['manifest_urls'].blank?
    # Get the next and previous docs
    m_previous_and_next_documents(m_params)
    # Get the related annotations and transcriptions
    related_annotations
    related_transcriptions
    respond_to do |format|
      format.html do
        render
      end
    end
  end

  private

  def related_annotations
    @related_annotations = {}
    qparams = { q: "manuscript_search:\"#{@document['title_display']}", rows: 0 }
    self.search_params_logic += [:add_annotation_filter]
    self.search_params_logic -= [:all_search_filter, :add_manuscript_filter, :add_transcription_filter]
    (resp, _doc_list) = get_search_results(qparams)
    @related_annotations[@document['title_display']] = resp['response']['numFound']
  end

  def related_transcriptions
    @related_transcriptions = {}
    qparams = { q: "manuscript_search:\"#{@document['title_display']}", rows: 0 }
    self.search_params_logic += [:add_transcription_filter]
    self.search_params_logic -= [:all_search_filter, :add_manuscript_filter, :add_annotation_filter]
    (resp, _doc_list) = get_search_results(qparams)
    @related_transcriptions[@document['title_display']] = resp['response']['numFound']
  end

  def m_previous_and_next_documents(m_params)
    @prev_doc = {}
    @next_doc = {}
    return if m_params.blank? || m_params[:start].blank?
    nav_docs = get_previous_and_next_documents_for_search(m_params[:start], m_params, {})
    if nav_docs.second && !nav_docs.second.first.blank? && m_params[:start] > 0
      index = m_params[:start] - 1
      @prev_doc['path'] = url_for(controller: 'manuscript', action: 'show', id: nav_docs.second.first['druid'], params: {start: index})
      @prev_doc['title'] = nav_docs.second.first['title_display'] || nav_docs.second.first['druid']

    end
    if nav_docs.second && !nav_docs.second.second.blank? && m_params[:start] < nav_docs.first['response']['numFound'] - 1
      index = m_params[:start] + 1
      @next_doc['path'] = url_for(controller: 'manuscript', action: 'show', id: nav_docs.second.second['druid'], params: {start: index})
      @next_doc['title'] = nav_docs.second.second['title_display'] || nav_docs.second.second['druid']
    end
  end

  def current_query
    return if session[:m_last_search_query].blank? && session[:m_current_display_query].blank?
    if session[:m_current_display_query]
      m_params = JSON.parse(session[:m_current_display_query])
    else
      m_params = JSON.parse(session[:m_last_search_query])
    end
    if params[:start]
      begin
        Integer(params[:start])
      rescue
        return nil
      end
      m_params['start'] = Integer(params[:start])
    end
    return nil unless m_params['start']
    session[:m_current_display_query] = m_params.to_json
    m_params['qt'] = 'descriptions'
    m_params.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end
end

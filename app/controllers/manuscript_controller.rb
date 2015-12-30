class ManuscriptController < ApplicationController
  include Blacklight::Configurable
  include Blacklight::SolrHelper
  include Blacklight::Catalog::SearchContext
  copy_blacklight_config_from(CatalogController)

  layout 'blacklight'

  def show
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
    @contents = []
    @contents = IiifManifest.new(@document['manifest_urls'].first).contents unless @document['manifest_urls'].blank?
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
end

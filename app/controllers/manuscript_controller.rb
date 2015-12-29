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
    respond_to do |format|
      format.html do
        render
      end
    end
  end
end

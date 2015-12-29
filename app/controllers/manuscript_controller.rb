class ManuscriptController < ApplicationController
  include Blacklight::Configurable
  include Blacklight::SolrHelper
  include Blacklight::Catalog::SearchContext
  copy_blacklight_config_from(CatalogController)

  layout 'blacklight'

  def show
    @response, @document = get_solr_response_for_doc_id params[:id]
    respond_to do |format|
      format.html do
        render
      end
    end
  end
end

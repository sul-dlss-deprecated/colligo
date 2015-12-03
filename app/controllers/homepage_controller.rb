class HomepageController < ApplicationController
  include Hydra::Controller::ControllerBehavior
  include Blacklight::Catalog::SearchContext
  include Blacklight::SearchHelper
  include Hydra::Controller::SearchBuilder

  #self.search_params_logic += [:show_only_generic_files, :add_access_controls_to_solr_params]
  #layout 'homepage'

  def index
    manuscripts
  end

  protected
  
    def manuscripts
      # grab any recent documents
      (_, @recent_documents) = search_results({ q: '', sort: sort_field, rows: 4 }, search_params_logic)      
    end

    def sort_field
      "#{Solrizer.solr_name('system_create', :stored_sortable, type: :date)} desc"
    end
end

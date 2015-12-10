module Colligo
  module Search
    module Defaults
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
          config.default_solr_params = {
            :qt => 'search',
            :rows => 10
          }

          # solr path which will be added to solr base url before the other solr params.
          #config.solr_path = 'select' 

          # items to show per page, each number in the array represent another option to choose from.
          #config.per_page = [10,20,50,100]

          ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SearchHelper#solr_doc_params) or
          ## parameters included in the Blacklight-jetty document requestHandler.
          #
          #config.default_document_solr_params = {
          #  :qt => 'document',
          #  ## These are hard-coded in the blacklight 'document' requestHandler
          #  # :fl => '*',
          #  # :rows => 1
          #  # :q => '{!raw f=id v=$id}' 
          #}
        end
      end
    end
  end
end

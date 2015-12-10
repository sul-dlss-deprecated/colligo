module Colligo
  module Search
    module ViewConfiguration
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          # solr field configuration for search results/index views
          config.index.title_field = 'title_display'
          config.index.display_type_field = 'format'
        end
      end
    end
  end
end

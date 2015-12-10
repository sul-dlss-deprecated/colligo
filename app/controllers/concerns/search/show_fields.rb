module Colligo
  module Search
    module ShowFields
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          # solr field configuration for document/show views
          #config.show.title_field = 'title_display'
          #config.show.display_type_field = 'format'
        end
      end
    end
  end
end

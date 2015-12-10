module Colligo
  module Search
    module SortFields
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          # "sort results by" select (pulldown)
          # label in pulldown is followed by the name of the SOLR field to sort by and
          # whether the sort is ascending or descending (it must be asc or desc
          # except in the relevancy case).
          config.add_sort_field 'score desc, title_sort asc', :label => 'relevance'
          config.add_sort_field 'authors_all_facet asc, title_sort asc', :label => 'author'
          config.add_sort_field 'pub_date_sort asc, title_sort asc', :label => 'date'

          # If there are more than this many search results, no spelling ("did you 
          # mean") suggestion is offered.
          config.spell_max = 5
        end
      end
    end
  end
end

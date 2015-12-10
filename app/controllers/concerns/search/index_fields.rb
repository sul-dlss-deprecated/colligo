module Colligo
  module Search
    module IndexFields
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          # solr fields to be displayed in the index (search results) view
          #   The ordering of the field names is the order of the display 
          config.add_index_field 'title_display', :label => 'Title'
          config.add_index_field 'authors_all_display', :label => 'Author'
          config.add_index_field 'format', :label => 'Format'
          config.add_index_field 'language', :label => 'Language'
          config.add_index_field 'abstract_display', :label => 'Abstract'
          config.add_index_field 'topic_display', :label => 'Topic'
          config.add_index_field 'geographic_display', :label => 'Region'
          config.add_index_field 'era_display', :label => 'Era'
          config.add_index_field 'pub_date_display', :label => 'Date'
          config.add_index_field 'collection', :label => 'Repository'
          # solr fields to be displayed in the show (single result) view
          #   The ordering of the field names is the order of the display 
          config.add_show_field 'title_display', :label => 'Title'
          config.add_show_field 'subtitle_display', :label => 'Subtitle'
          config.add_show_field 'title_alternate_display', :label => 'Alternate titles'
          config.add_show_field 'title_other_display', :label => 'Other titles'
          config.add_show_field 'authors_all_display', :label => 'Author'
          config.add_show_field 'format', :label => 'Format'
          config.add_show_field 'language', :label => 'Language'
          config.add_show_field 'pub_date_display', :label => 'Date'
          config.add_show_field 'collection', :label => 'Repository'
        end
      end
    end
  end
end

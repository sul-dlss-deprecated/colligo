module Colligo
  module Search
    module FacetFields
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          # solr fields that will be treated as facets by the blacklight application
          #   The ordering of the field names is the order of the display
          #
          # Setting a limit will trigger Blacklight's 'more' facet values link.
          # * If left unset, then all facet values returned by solr will be displayed.
          # * If set to an integer, then "f.somefield.facet.limit" will be added to
          # solr request, with actual solr request being +1 your configured limit --
          # you configure the number of items you actually want _displayed_ in a page.    
          # * If set to 'true', then no additional parameters will be sent to solr,
          # but any 'sniffed' request limit parameters will be used for paging, with
          # paging at requested limit -1. Can sniff from facet.limit or 
          # f.specific_field.facet.limit solr request params. This 'true' config
          # can be used if you set limits in :default_solr_params, or as defaults
          # on the solr side in the request handler itself. Request handler defaults
          # sniffing requires solr requests to be made with "echoParams=all", for
          # app code to actually have it echo'd back to see it.  
          #
          # :show may be set to false if you don't want the facet to be drawn in the 
          # facet bar

          config.add_facet_field 'format', :label => 'Format'
          config.add_facet_field 'type_of_resource_facet', :label => 'Type of resource'
          config.add_facet_field 'authors_all_facet', :label => 'Authors'
          config.add_facet_field 'topic_facet', :label => 'Topic', :limit => 20
          config.add_facet_field 'geographic_facet', :label => 'Region'
          config.add_facet_field 'era_facet', :label => 'Era'
          config.add_facet_field 'manuscript_facet', :label => 'Manuscript'
          config.add_facet_field 'language', :label => 'Language', :limit => true
          config.add_facet_field 'place_search', :label => 'Place of origin'
          config.add_facet_field 'model', :label => 'Type'
          config.add_facet_field 'folio', :label => 'Folio'
          config.add_facet_field 'collection', :label => 'Repository'

          config.add_facet_field 'example_pivot_field', :label => 'Pivot Field', :pivot => ['format', 'language']

          config.add_facet_field 'date_range', :label => 'Century', :query => {
             :years_21 => { :label => '21st', :fq => "pub_date_t:[2000 TO *]" },
             :years_20 => { :label => '20th', :fq => "pub_date_t:[1900 TO 1999]" },
             :years_19 => { :label => '19th', :fq => "pub_date_t:[1800 TO 1899]" },
             :years_18 => { :label => '18th', :fq => "pub_date_t:[1700 TO 1799]" },
             :years_17 => { :label => '17th', :fq => "pub_date_t:[1600 TO 1699]" },
             :years_16 => { :label => '16th', :fq => "pub_date_t:[1500 TO 1599]" },
             :years_15 => { :label => '15th', :fq => "pub_date_t:[1400 TO 1499]" },
             :years_14 => { :label => '14th', :fq => "pub_date_t:[1300 TO 1399]" },
             :years_13 => { :label => '13th', :fq => "pub_date_t:[1200 TO 1299]" },
             :years_12 => { :label => '12th', :fq => "pub_date_t:[1100 TO 1199]" },
             :years_11 => { :label => '11th', :fq => "pub_date_t:[1000 TO 1099]" },
             :years_10 => { :label => '10th', :fq => "pub_date_t:[900 TO 999]" },
             :years_9 => { :label => '9th', :fq => "pub_date_t:[800 TO 899]" },
             :years_8 => { :label => '8th', :fq => "pub_date_t:[700 TO 799]" },
             :years_7 => { :label => '7th', :fq => "pub_date_t:[600 TO 699]" },
             :years_6 => { :label => '6th', :fq => "pub_date_t:[500 TO 599]" },
             :years_5 => { :label => '5th', :fq => "pub_date_t:[400 TO 499]" },
             :years_4 => { :label => '4th', :fq => "pub_date_t:[300 TO 399]" },
             :years_3 => { :label => '3rd', :fq => "pub_date_t:[200 TO 299]" },
             :years_2 => { :label => '2nd', :fq => "pub_date_t:[100 TO 199]" },
             :years_1 => { :label => '1st', :fq => "pub_date_t:[0 TO 99]" }
          }

          config.add_facet_field 'pub_date_t', :label => 'Publication Year', :range => {
            :num_segments => 21,
            :assumed_boundaries => [0, 2999],
            :segments => true
          }

          # Have BL send all facet field names to Solr, which has been the default
          # previously. Simply remove these lines if you'd rather use Solr request
          # handler defaults, or have no facets.
          config.add_facet_fields_to_solr_request!
        end
      end
    end
  end
end

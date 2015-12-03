# -*- encoding : utf-8 -*-
class CatalogController < ApplicationController
  include Blacklight::Marc::Catalog

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      qt: 'search',
      rows: 10
    }

    # solr path which will be added to solr base url before the other solr params.
    # config.solr_path = 'select'

    # items to show per page, each number in the array represent another option to choose from.
    # config.per_page = [10,20,50,100]

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SearchHelper#solr_doc_params) or
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    # config.default_document_solr_params = {
    #  :qt => 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # :fl => '*',
    #  # :rows => 1
    #  # :q => '{!raw f=id v=$id}'
    # }

    # solr field configuration for search results/index views
    config.index.title_field = 'title_display'
    config.index.display_type_field = 'format'

    # solr field configuration for document/show views
    # config.show.title_field = 'title_display'
    # config.show.display_type_field = 'format'

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

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

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

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', label: 'All Fields'

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.
      field.solr_parameters = { 'spellcheck.dictionary': 'title' }

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = {
        qf: '$title_qf',
        pf: '$title_pf'
      }
    end

    config.add_search_field('author') do |field|
      field.solr_parameters = { 'spellcheck.dictionary': 'author' }
      field.solr_local_parameters = {
        qf: '$author_qf',
        pf: '$author_pf'
      }
    end

    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as
    # config[:default_solr_parameters][:qt], so isn't actually neccesary.
    config.add_search_field('subject') do |field|
      field.solr_parameters = { 'spellcheck.dictionary': 'subject' }
      field.qt = 'search'
      field.solr_local_parameters = {
        qf: '$subject_qf',
        pf: '$subject_pf'
      }
    end

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

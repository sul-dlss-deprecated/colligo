# -*- encoding : utf-8 -*-
class CatalogController < ApplicationController
  include Blacklight::Marc::Catalog

  include Blacklight::Catalog
  layout :resolve_layout

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      qt: 'search',
      rows: 10
    }

    # solr field configuration for search results/index views
    config.index.title_field = 'title_display'
    config.index.display_type_field = 'format'

    config.add_facet_field 'format', label: 'Format'
    config.add_facet_field 'type_of_resource_facet', label: 'Type of resource'
    config.add_facet_field 'authors_all_facet', label: 'Authors'
    config.add_facet_field 'topic_facet', label: 'Topic', limit: 20
    config.add_facet_field 'geographic_facet', label: 'Region'
    config.add_facet_field 'era_facet', label: 'Era'
    config.add_facet_field 'manuscript_facet', label: 'Manuscript'
    config.add_facet_field 'language', label: 'Language', limit: 5
    config.add_facet_field 'place_search', label: 'Place of origin'
    config.add_facet_field 'model', label: 'Type'
    config.add_facet_field 'folio', label: 'Folio'
    config.add_facet_field 'collection', label: 'Repository'
    config.add_facet_field 'example_pivot_field', label: 'Pivot Field', pivot: %w(format language)
    config.add_facet_field 'date_range', label: 'Century', query: {
      years_21: { label: '21st', fq: 'pub_date_t:[2000 TO *]' },
      years_20: { label: '20th', fq: 'pub_date_t:[1900 TO 1999]' },
      years_19: { label: '19th', fq: 'pub_date_t:[1800 TO 1899]' },
      years_18: { label: '18th', fq: 'pub_date_t:[1700 TO 1799]' },
      years_17: { label: '17th', fq: 'pub_date_t:[1600 TO 1699]' },
      years_16: { label: '16th', fq: 'pub_date_t:[1500 TO 1599]' },
      years_15: { label: '15th', fq: 'pub_date_t:[1400 TO 1499]' },
      years_14: { label: '14th', fq: 'pub_date_t:[1300 TO 1399]' },
      years_13: { label: '13th', fq: 'pub_date_t:[1200 TO 1299]' },
      years_12: { label: '12th', fq: 'pub_date_t:[1100 TO 1199]' },
      years_11: { label: '11th', fq: 'pub_date_t:[1000 TO 1099]' },
      years_10: { label: '10th', fq: 'pub_date_t:[900 TO 999]' },
      years_9: { label: '9th', fq: 'pub_date_t:[800 TO 899]' },
      years_8: { label: '8th', fq: 'pub_date_t:[700 TO 799]' },
      years_7: { label: '7th', fq: 'pub_date_t:[600 TO 699]' },
      years_6: { label: '6th', fq: 'pub_date_t:[500 TO 599]' },
      years_5: { label: '5th', fq: 'pub_date_t:[400 TO 499]' },
      years_4: { label: '4th', fq: 'pub_date_t:[300 TO 399]' },
      years_3: { label: '3rd', fq: 'pub_date_t:[200 TO 299]' },
      years_2: { label: '2nd', fq: 'pub_date_t:[100 TO 199]' },
      years_1: { label: '1st', fq: 'pub_date_t:[0 TO 99]' }
    }
    config.add_facet_field 'pub_date_t', label: 'Publication Year', range: {
      num_segments: 21,
      assumed_boundaries: [0, 2999],
      segments: true
    }

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field 'title_display', label: 'Title'
    config.add_index_field 'authors_all_display', label: 'Author'
    config.add_index_field 'format', label: 'Format'
    config.add_index_field 'language', label: 'Language'
    config.add_index_field 'abstract_display', label: 'Abstract'
    config.add_index_field 'topic_display', label: 'Topic'
    config.add_index_field 'geographic_display', label: 'Region'
    config.add_index_field 'era_display', label: 'Era'
    config.add_index_field 'pub_date_display', label: 'Date'
    config.add_index_field 'collection', label: 'Repository'
    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field 'title_display', label: 'Title'
    config.add_show_field 'subtitle_display', label: 'Subtitle'
    config.add_show_field 'title_alternate_display', label: 'Alternate titles'
    config.add_show_field 'title_other_display', label: 'Other titles'
    config.add_show_field 'authors_all_display', label: 'Author'
    config.add_show_field 'format', label: 'Format'
    config.add_show_field 'language', label: 'Language'
    config.add_show_field 'pub_date_display', label: 'Date'
    config.add_show_field 'collection', label: 'Repository'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    config.add_search_field 'all_fields', label: 'All Fields'

    config.add_search_field('descriptions') do |field|
      field.qt = 'descriptions'
    end

    config.add_search_field('transcriptions') do |field|
      field.qt = 'transcriptions'
    end

    config.add_search_field('annotations') do |field|
      field.qt = 'annotations'
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, title_sort asc', label: 'relevance'
    config.add_sort_field 'authors_all_facet asc, title_sort asc', label: 'author'
    config.add_sort_field 'pub_date_sort asc, title_sort asc', label: 'date'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end

  def index
    if on_home_page
      manuscripts
      plot_data
      render 'homepage'
    else
      super
    end
  end

  private

  def manuscripts
    self.search_params_logic += [:add_manuscript_filter]
    (@response_m, @document_list_m) = get_search_results
  end

  def resolve_layout
    if on_home_page
      'homepage'
    else
      'blacklight'
    end
  end

  def plot_data
    data = solr_range_queries_to_a('pub_date_t')
    @data_array = []
    @data_ticks = []
    @pointer_lookup = []
    @slider_ticks = []
    @slider_positions = []
    @slider_labels = []
    data.each do |val|
      @data_array << [val[:count], val[:from]]
      if val[:from] == 0
        label = '1st'
      elsif val[:from] == 100
        label = '2nd'
      elsif val[:from] == 200
        label = '3rd'
      else
        label = "#{((val[:from] / 100) + 1)}th"
      end
      @data_ticks << [val[:from], label]
      @slider_labels << label
      @pointer_lookup << { 'from': val[:from], 'to': val[:to], 'count': val[:count], 'label': "#{val[:from]} to #{val[:to]}" }
    end
    @boundaries = [@data_array.first.last, @data_array.last.last + 99]
  end

  def solr_range_queries_to_a(solr_field)
    return [] unless @response_m['facet_counts'] && @response_m['facet_counts']['facet_queries']
    array = []
    @response_m['facet_counts']['facet_queries'].each_pair do |query, count|
      if query =~ /#{solr_field}: *\[ *(\d+) *TO *(\d+) *\]/
        array << { from: Regexp.last_match(1).to_i, to: Regexp.last_match(2).to_i, count: count.to_i }
      end
    end
    array = array.sort_by { |hash| hash[:from].to_i }
    array
  end
end

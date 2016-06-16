module FacetsHelper
  include Blacklight::FacetsHelperBehavior

  ##
  # Render a collection of facet fields.
  # @see #render_refine_facet_limit
  #
  # @param [Array<String>]
  # @param [Hash] options
  # @return String
  def render_refine_facet_partials(fields = facet_field_names, options = {})
    safe_join(facets_from_request(fields).map do |display_facet|
      render_refine_facet_limit(display_facet, options)
    end.compact, "\n")
  end

  def render_facet_tabs(fields = facet_field_names, options = {})
    count = 0
    tabs = []
    facets_from_request(fields).map do |display_facet|
      next unless should_render_facet?(display_facet)
      options[:locals] ||= {}
      options[:locals][:index] = count
      tabs << render_facet_tab(facet_configuration_for_field(display_facet.name), options)
      count += 1
    end
    safe_join(tabs.compact, "\n")
  end

  def render_facet_tab(facet, options)
    active = ''
    active = 'active' if options[:locals][:index] == 0
    "<li class=\"#{active}\" data-tab-id=\"#{facet_field_id(facet)}\"><a href=\"##{facet_field_id(facet)}\" class=\"disabled\" data-toggle=\"tab\">#{facet['label']}</a></li>".html_safe
  end

  def render_refine_facet_limit(display_facet, options = {})
    options = options.dup
    options[:partial] ||= 'refine_facet_limit' # facet_partial_name(display_facet)
    options[:layout] ||= 'refine_facet_layout' unless options.key?(:layout)
    options[:locals] ||= {}
    options[:locals][:field_name] ||= display_facet.name
    options[:locals][:solr_field] ||= display_facet.name # deprecated
    options[:locals][:facet_field] ||= facet_configuration_for_field(display_facet.name)
    options[:locals][:display_facet] ||= display_facet
    options[:locals][:facet_id] ||= facet_field_id(facet_configuration_for_field(display_facet.name))
    options[:locals][:tab_classes] = ''
    render(options)
  end

  ##
  # Renders the list of values
  # removes any elements where render_facet_item returns a nil value. This enables an application
  # to filter undesireable facet items so they don't appear in the UI
  def render_refine_facet_limit_list(paginator, facet_field, wrapping_element = :tr)
    safe_join(paginator.items
        .map { |item| render_refine_facet_item(facet_field, item) }.compact
        .map { |item| content_tag(wrapping_element, item) })
  end

  ##
  # Renders a single facet item
  def render_refine_facet_item(facet_field, item)
    if facet_in_params?(facet_field, item.value)
      render_refine_selected_facet_value(facet_field, item)
    else
      render_refine_facet_value(facet_field, item)
    end
  end

  ##
  # Standard display of a facet value in a list. Used in both _facets sidebar
  # partial and catalog/facet expanded list. Will output facet value name as
  # a link to add that to your restrictions, with count in parens.
  #
  # @param [Blacklight::Solr::Response::Facets::FacetField]
  # @param [String] facet item
  # @param [Hash] options
  # @option options [Boolean] :suppress_link display the facet, but don't link to it
  # @return [String]
  def render_refine_facet_value(facet_field, item, options = {})
    path = path_for_facet(facet_field, item)
    content_tag(:td, class: 'facet-label') do
      link_to_unless(options[:suppress_link], facet_display_value(facet_field, item), path, class: 'facet_select')
    end + render_refine_facet_count(item.hits)
  end

  ##
  # Standard display of a SELECTED facet value (e.g. without a link and with a remove button)
  # @params (see #render_refine_facet_value)
  def render_refine_selected_facet_value(facet_field, item)
    content_tag(:td, class: 'facet-label') do
      content_tag(:span, facet_display_value(facet_field, item), class: 'selected') +
        # remove link
        link_to(content_tag(:span, '', class: 'glyphicon glyphicon-remove') + content_tag(:span, '[remove]', class: 'sr-only'),
                search_action_path(remove_facet_params(facet_field, item, params)), class: 'remove')
    end + render_refine_facet_count(item.hits, classes: ['selected'])
    # + content_tag(:td)
  end

  ##
  # Renders a count value for facet limits. Can be over-ridden locally
  # to change style. And can be called by plugins to get consistent display.
  #
  # @num [number of facet results
  # @options - hash of options.
  # @return [String]
  def render_refine_facet_count(num, options = {})
    classes = (options[:classes] || []) << 'facet-count'
    content_tag('td', t('blacklight.search.facets.count', number: number_with_delimiter(num)), class: classes)
  end
end

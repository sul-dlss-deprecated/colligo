require 'blacklight/search_state'
require 'blacklight/parameters'
# Includes methods for rendering constraints graphically on the
# search results page (render_constraints(_*))
module Colligo::RenderSimpleConstraintsHelperBehavior
  ##
  # Check if the query has any search constraints defined
  #
  # @param [Hash] query parameters
  # @return [Boolean]
  def query_has_search_constraints?(localized_params = params)
    !(localized_params[:q].blank?)
  end

  ##
  # Check if the query has any facet constraints defined
  #
  # @param [Hash] query parameters
  # @return [Boolean]
  def query_has_facet_constraints?(localized_params = params)
    return false unless localized_params.key?(:f)
    return false if localized_params[:f].blank?
    facetvals = {}
    localized_params[:f].each do |k, v|
      if v.is_a?(Array)
        facetvals[k] = v.reject(&:blank?)
      elsif !v.blank?
        facetvals[k] = [v]
      else
        facetvals[k] = [nil]
      end
    end
    facetvals.any? { |_k, v| !v.blank? && v.any? if v.is_a?(Array) }
  end

  ##
  # Render the actual constraints, not including header or footer
  # info.
  #
  # @param [Hash] query parameters
  # @return [String]
  def render_simple_constraints(localized_params = params)
    render_simple_constraints_query(localized_params) + render_simple_constraints_filters(localized_params)
  end

  ##
  # Render the query constraints
  #
  # @param [Hash] query parameters
  # @return [String]
  def render_simple_constraints_query(localized_params = params)
    # So simple don't need a view template, we can just do it here.
    scope = localized_params.delete(:route_set) || self
    return ''.html_safe if localized_params[:q].blank?
    render_simple_constraint_element(simple_constraint_query_label(localized_params),
                                     localized_params[:q],
                                     classes: ['simple-query query'])
    #:remove => scope.url_for(localized_params.merge(:q=>nil, :action=>'index')) )
  end

  ##
  # Render the facet constraints
  # @param [Hash] localized_params query parameters
  # @return [String]
  def render_simple_constraints_filters(localized_params = params)
    return ''.html_safe unless localized_params[:f]
    path = Blacklight::SearchState.new(localized_params, blacklight_config)
    content = []
    localized_params[:f].each_pair do |facet, values|
      content << render_simple_filter_element(facet, values, path)
    end

    safe_join(content.flatten, "\n")
  end

  ##
  # Render a single facet's constraint
  # @param [String] facet field
  # @param [Array<String>] values selected facet values
  # @param [Blacklight::SearchState] path query parameters
  # @return [String]
  def render_simple_filter_element(facet, values, path)
    facet_config = facet_configuration_for_field(facet)

    safe_join(values.map do |val|
      next if val.blank? # skip empty string
      render_simple_constraint_element(facet_field_label(facet_config.key), facet_display_value(facet, val),
                                       remove: search_action_path(path.remove_facet_params(facet, val)),
                                       classes: ['filter', 'simple-filter', 'filter-' + facet.parameterize]
                                      )
    end, "\n")
  end

  # Render a label/value constraint on the screen. Can be called
  # by plugins and such to get application-defined rendering.
  #
  # Can be over-ridden locally to render differently if desired,
  # although in most cases you can just change CSS instead.
  #
  # Can pass in nil label if desired.
  #
  # @param [String] label to display
  # @param [String] value to display
  # @param [Hash] options
  # @option options [String] :remove url to execute for a 'remove' action
  # @option options [Array<String>] :classes an array of classes to add to container span for constraint.
  # @return [String]
  def render_simple_constraint_element(label, value, options = {})
    render(partial: 'shared/simple_constraints_element', locals: { label: label, value: value, options: options })
  end

  def simple_constraint_query_label(localized_params = params)
    label_for_search_field(localized_params[:search_field])
  end
end

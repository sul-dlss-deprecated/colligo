# Includes methods for rendering constraints graphically on the
# search results page (render_constraints(_*))
module Colligo
  module RenderBreadcrumbsHelperBehavior
    ##
    # Render the facet constraints
    # @param [Hash] localized_params query parameters
    # @return [String]
    def render_breadcrumb_constraints_filters(localized_params = params)
      return ''.html_safe unless localized_params[:f]
      content = []
      remaining_params = localized_params.except(:f)
      localized_params[:f].each_pair do |facet, values|
        content << render_breadcrumb_filter_element(facet, values, remaining_params)
      end
      safe_join(content.flatten, ' > ')
    end

    ##
    # Render a single facet's constraint
    # @param [String] facet field
    # @param [Array<String>] values selected facet values
    # @param path query parameters
    # @return [String]
    def render_breadcrumb_filter_element(facet, values, remaining_params)
      facet_config = facet_configuration_for_field(facet)
      safe_join(values.map do |val|
        next if val.blank? # skip empty string
        local_params = add_facet_params(facet, val, source_params = remaining_params)
        render_breadcrumb_constraint_element(facet_field_label(facet_config.key), facet_display_value(facet, val),
                                             search_path: search_action_path(local_params),
                                             classes: ['filter', 'breadcrumb-filter', 'filter-' + facet.parameterize])
      end, ' | ')
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
    def render_breadcrumb_constraint_element(label, value, options = {})
      render(partial: 'shared/breadcrumb_constraints_element', locals: { label: label, value: value, options: options })
    end
  end
end

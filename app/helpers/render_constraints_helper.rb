require 'blacklight/search_state'
require 'blacklight/parameters'
module RenderConstraintsHelper
  include Blacklight::RenderConstraintsHelperBehavior
  include Colligo::RenderSimpleConstraintsHelperBehavior
  include Colligo::RenderBreadcrumbsHelperBehavior
end

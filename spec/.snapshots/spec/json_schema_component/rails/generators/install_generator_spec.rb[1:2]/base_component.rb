# frozen_string_literal: true

require "json_schema_view"

# @abstract
class BaseComponent < ::JsonSchemaView::BaseComponent
  # You can configure how this components is rendered.
  # 
  # There are some preset renderers:
  # * `:json` - serialize the component as json text.
  # * `:react_on_rails` - render the component by using react_on_rails gem.
  renderer_class(:react_on_rails)

  def base_props_class
    BaseProps
  end
end

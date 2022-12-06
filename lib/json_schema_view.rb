# frozen_string_literal: true

require "active_support"

require_relative "json_schema_view/json_schema_definable"
require_relative "json_schema_view/base_component"
require_relative "json_schema_view/base_props"
require_relative "json_schema_view/configuration"
require_relative "json_schema_view/json_world_extensions"
require_relative "json_schema_view/rails"
require_relative "json_schema_view/renderers"
require_relative "json_schema_view/schema_set"
require_relative "json_schema_view/version"

# A view library with JSON Schema.
module JsonSchemaView
  class << self
    # @yield (see JsonSchemaView::Configuration.configure)
    # @yieldparam (see JsonSchemaView::Configuration.configure)
    def configure(&block)
      Configuration.configure(&block)
    end

    # @return [JsonSchemaView::Configuration]
    def configuration
      Configuration.instance
    end
  end
end

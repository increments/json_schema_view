# frozen_string_literal: true

require "active_support"

require_relative "json_schema_component/api_resource"
require_relative "json_schema_component/base_component"
require_relative "json_schema_component/base_props"
require_relative "json_schema_component/configuration"
require_relative "json_schema_component/json_world_extensions"
require_relative "json_schema_component/rails"
require_relative "json_schema_component/renderers"
require_relative "json_schema_component/schema_set"
require_relative "json_schema_component/version"

# A view library with JSON Schema.
module JsonSchemaComponent
  class << self
    # @yield (see JsonSchemaComponent::Configuration.configure)
    # @yieldparam (see JsonSchemaComponent::Configuration.configure)
    def configure(&block)
      Configuration.configure(&block)
    end

    # @return [JsonSchemaComponent::Configuration]
    def configuration
      Configuration.instance
    end
  end
end

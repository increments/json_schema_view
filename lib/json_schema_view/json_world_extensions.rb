# frozen_string_literal: true

require "active_support"

module JsonSchemaView
  # A collection of extensions for {JsonWorld::DSL} to support recent JSON Schema.
  # @private
  module JsonWorldExtensions
    require_relative "json_world_extensions/additional_properties"
    require_relative "json_world_extensions/any_of"
    require_relative "json_world_extensions/camelizable"
    require_relative "json_world_extensions/compact_optional_properties"
    require_relative "json_world_extensions/constant_property"
    require_relative "json_world_extensions/declarable"
    require_relative "json_world_extensions/enum_type"
    require_relative "json_world_extensions/map_type"
    require_relative "json_world_extensions/validatable"

    # @see https://json-schema.org/specification.html
    module Schema202012
      extend ActiveSupport::Concern

      include AdditionalProperties
      include AnyOf::DSL
      include ConstantProperty
      include Declarable
      include EnumType::DSL
      include MapType::DSL
    end
  end
end

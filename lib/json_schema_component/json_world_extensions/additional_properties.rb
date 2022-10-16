# frozen_string_literal: true

require "active_support"

module JsonSchemaComponent
  module JsonWorldExtensions
    # Define JSON Schema's additionalProperties property.
    # @see https://json-schema.org/understanding-json-schema/reference/object.html#additional-properties
    #
    # @example
    #   class Zoo
    #     include JsonWorld::DSL
    #     include JsonSchemaComponent::JsonWorldExtensions::MapType::DSL
    #
    #     additional_properties(false)
    #     property(
    #       :dogMap,
    #       type: map_type(Dog),
    #     )
    #   end
    module AdditionalProperties
      extend ActiveSupport::Concern

      class_methods do
        # @override {Class.override}
        def inherited(child)
          super
          child.additional_properties(additional_properties)
        end

        # Return the additionalProperties property.
        # Set the additionalProperties property if arguments are given.
        # @see https://json-schema.org/draft/2020-12/json-schema-core.html#additionalProperties
        # @see https://json-schema.org/understanding-json-schema/reference/object.html#id5
        #
        # @param value [false, Hash]
        # @param value_keywords [Hash]
        def additional_properties(value = nil, **value_keywords)
          return @additional_properties = value unless value.nil?
          return @additional_properties = value_keywords unless value_keywords.empty?

          @additional_properties
        end

        # @override {JsonWorld::DSL::ClassMethods#as_json_schema}
        def as_json_schema
          # Do not allow undefined properities.
          # @see https://json-schema.org/understanding-json-schema/reference/object.html#additionalproperties
          if @additional_properties.nil?
            super
          else
            super.merge("additionalProperties": @additional_properties)
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module JsonSchemaComponent
  module JsonWorldExtensions
    # This module allows {JsonWorld::DSL::ClassMethods#property} to define enum values.
    # Defined constant values are reflect to JSON Schema.
    # @see https://json-schema.org/understanding-json-schema/reference/generic.html#enumerated-values
    # @example
    #   class Zoo
    #     include JsonWorld::DSL
    #     include JsonSchemaComponent::JsonWorldExtensions::EnumType::DSL
    #     property(
    #       :animal,
    #       type: enum_type("Dog", "Cat"),
    #     )
    #   end
    class EnumType
      module DSL
        extend ActiveSupport::Concern

        class_methods do
          def enum_type(*args)
            JsonWorldExtensions::EnumType.new(*args)
          end
        end
      end

      attr_reader :candidates

      # @param type [String, Symbol, #as_json_schema]
      # @param candidates [Array<Object>]
      def initialize(*candidates)
        @candidates = candidates
      end

      def as_json_schema
        {
          enum: candidates
        }
      end

      alias as_json_schema_without_links as_json_schema
    end
  end
end

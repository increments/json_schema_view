# frozen_string_literal: true

module JsonSchemaComponent
  module JsonWorldExtensions
    # This class implements `anyOf` schema composition.
    # Instances of this class acts as an json world compatible object and prints the schema for anyOf combination.
    # @see https://json-schema.org/understanding-json-schema/reference/combining.html#id6
    # @example
    #   class Zoo
    #     include JsonWorld::DSL
    #     include JsonSchemaComponent::JsonWorldExtensions::MapType::DSL
    #     property(
    #       :animal,
    #       type: any_of.new(Dog, Cat),
    #     )
    #   end
    class AnyOf
      module DSL
        extend ActiveSupport::Concern

        class_methods do
          def any_of(*types)
            JsonWorldExtensions::AnyOf.new(*types)
          end
        end
      end

      attr_reader :types

      def initialize(*types)
        @types = types
      end

      def as_json_schema
        { "anyOf" => types.map(&:as_json_schema) }
      end

      alias as_json_schema_without_links as_json_schema
    end
  end
end

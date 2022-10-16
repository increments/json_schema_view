# frozen_string_literal: true

module JsonSchemaComponent
  module JsonWorldExtensions
    # This class implements map type (string keys to values with the given type) in JSON Schema.
    # You can specify the type of values but you cannot specify the type of keys,
    # because JSON and JSON Schema only support String keys in objects.
    #
    # @see https://json-schema.org/understanding-json-schema/reference/object.html#additional-properties
    #
    # @example
    #   class Zoo
    #     include JsonWorld::DSL
    #     include JsonSchemaComponent::JsonWorldExtensions::MapType::DSL
    #     property(
    #       :dogMap,
    #       type: map_type(Dog),
    #     )
    #   end
    class MapType
      module DSL
        extend ActiveSupport::Concern

        class_methods do
          def map_type(type)
            JsonWorldExtensions::MapType.new(type)
          end
        end
      end

      attr_reader :type

      def initialize(type)
        @type = type
      end

      def as_json_schema
        {
          type: "object",
          additionalProperties: JsonWorld::PropertyDefinition.new(type: type).as_json_schema
        }
      end

      alias as_json_schema_without_links as_json_schema
    end
  end
end

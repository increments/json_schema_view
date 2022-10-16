# frozen_string_literal: true

module JsonSchemaComponent
  module JsonWorldExtensions
    # This module automatically removes properties with null value from encoded json if the property is optional.
    #
    # JSON Schema distinguishs a optional property and a nullable property.
    # If the value of a optional property is empty, you should remove the property from the encoded json.
    # This module make safe such the optional properties.
    # @see https://json-schema.org/understanding-json-schema/reference/object.html#required-properties
    module CompactOptionalProperties
      # @note Overrides {JsonWorld::JsonEncodable#properties}
      def properties(options)
        optional_property_names = self.class.property_definitions.select(&:optional?).map(&:property_name)

        super(options).reject { |key, value| value.nil? && optional_property_names.include?(key) }
      end
    end
  end
end

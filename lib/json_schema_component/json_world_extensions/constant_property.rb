# frozen_string_literal: true

module JsonSchemaComponent
  module JsonWorldExtensions
    # This module allows {JsonWorld::DSL::ClassMethods#property} to define constant values.
    # Defined constant values are reflect to JSON Schema.
    # @see https://json-schema.org/understanding-json-schema/reference/generic.html#constant-values
    module ConstantProperty
      extend ActiveSupport::Concern

      class_methods do
        # If property is defined with `const` parameter, define an instance method to return the value.
        # @note Overrides {JsonWorld::DSL::ClassMethods#property}
        def property(name, **options)
          if options[:const]
            const = options[:const].freeze
            define_method(name) { const }
          end

          super(name, **options)
        end

        # Add constant values informations JSON Schema
        # @note Overrides {JsonWorld::DSL::ClassMethods#as_json_schema}
        def as_json_schema
          property_hash = property_definitions.map do |property|
            if (const = property.raw_options[:const])
              # For now, use enumerated values instead of constant values.
              [property.property_name, { const: const }]
            else
              nil
            end
          end.compact.to_h
          super.deep_merge(properties: property_hash)
        end
      end
    end
  end
end

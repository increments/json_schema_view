# frozen_string_literal: true

require "active_support"

module JsonSchemaComponent
  module JsonWorldExtensions
    # Make the object to be serialized with camelized properties.
    module Camelizable
      extend ActiveSupport::Concern

      class_methods do
        # @param (see JsonWorld::DSL::ClassMethods#property)
        # @param camelize [Boolean] if true, camelize the property name on json format.
        def property(raw_property_name, camelize: true, **options)
          raw_property_name = raw_property_name.to_sym
          property_name = camelize ? camelize_name(raw_property_name) : raw_property_name

          super(property_name, **options)

          # Define a method with camelized name as an alias of the method with raw name.
          if camelize && property_name != raw_property_name
            define_method(property_name) do
              public_send(raw_property_name)
            end
          end
        end

        # @param name [String, Symbol]
        # @return [Symbol]
        def camelize_name(name)
          ActiveSupport::Inflector.camelize(name.to_s, false).to_sym
        end
      end
    end
  end
end

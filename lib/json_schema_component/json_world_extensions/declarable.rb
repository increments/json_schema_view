# frozen_string_literal: true

module JsonSchemaComponent
  module JsonWorldExtensions
    # Add methods to declare a common schema. Declared schema are exported as `$defs` property.
    #
    # @see: https://json-schema.org/understanding-json-schema/structuring.html#defs
    module Declarable
      extend ::ActiveSupport::Concern

      class_methods do
        attr_writer :declarations

        # @override {Class.inherited}
        def inherited(child)
          super
          child.declarations = declarations.clone
        end

        # @param type_or_name [Class<JsonWorld::DSL>, Symbol]
        # @param (see JsonWorld::DSL::ClassMethods#property)
        def declare(type_or_name, **options)
          property_type = options[:type] || type_or_name
          property_name = type_or_name.is_a?(Module) ? type_or_name.name.demodulize.to_sym : type_or_name.to_sym

          declaration = JsonWorld::PropertyDefinition.new(property_name: property_name, type: property_type, **options)
          declarations << declaration
        end

        # @override {JsonWorld::DSL::ClassMethods#as_json_schema}
        def as_json_schema
          decls = declarations_as_json_schema
          if decls.present?
            super.merge("$defs": decls)
          else
            super
          end
        end

        def declarations_as_json_schema
          declarations.inject({}) do |result, declaration|
            result.merge(
              declaration.property_name => declaration.as_json_schema
            )
          end
        end

        # @return [Array<PropertyDefinition>]
        def declarations
          @declarations ||= []
        end
      end
    end
  end
end

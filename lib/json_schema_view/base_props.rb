# frozen_string_literal: true

module JsonSchemaView
  # @abstract
  class BaseProps
    include JsonSchemaDefinable

    class << self
      # @note Override of {JsonWorld::DSL::ClassMethods#title}
      # @return [String] its component name with Props suffix.
      def title
        "#{ActiveSupport::Inflector.demodulize(component_name)}Props"
      end

      # @note Override of {JsonWorld::DSL::ClassMethods#description}
      # @return [String]
      def description
        "The property of #{ActiveSupport::Inflector.demodulize(component_name)}."
      end

      # @return [String] The name of its component class.
      def component_name
        component_class.name
      end

      # @return [Class<BaseComponent>] the component class this class belongs to.
      def component_class
        module_parent
      end
    end
  end
end

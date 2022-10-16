# frozen_string_literal: true

require "active_support"
require "forwardable"

module JsonSchemaComponent
  # @abstract
  class BaseComponent
    extend Forwardable

    class << self
      # @override {Class.override}
      def inherited(child)
        super
        child.renderer_class(renderer_class)
      end

      # (Re)define Props class under the class to express interface of props of the React component.
      # @return [Class<BaseProps>]
      def props_class(&definition)
        klass = if const_defined?(:Props, false)
                  const_get(:Props, false)
                else
                  const_set(:Props, Class.new(base_props_class))
                end

        klass.class_eval(&definition) if block_given?
        klass
      end

      # @return [Class<BaseProps>]
      def base_props_class
        JsonSchemaComponent::BaseProps
      end

      # @param new_renderer_class [Symbol, Class<Renderer::Base>]
      # @return [Class<Renderer::Base>]
      def renderer_class(new_renderer_class = nil)
        if new_renderer_class
          new_renderer_class = Renderers.find_by_name(new_renderer_class) if new_renderer_class.is_a?(Symbol)
          @renderer_class = new_renderer_class
        end
        @renderer_class
      end
    end

    # @return [self::Props]
    attr_reader :props

    # @return [JsonSchemaComponent::Renderers::Base]
    attr_reader :renderer

    delegate format: :renderer

    # @param props [Hash, self::Props] props of the React component.
    # @param validate [Boolean] if true, validate props besed on its schema before rendering.
    def initialize(props:, validate: true, **renderer_options)
      raise "Component instance cannot be created if no renderer is not defined" unless self.class.renderer_class

      @props = props.is_a?(self.class.props_class) ? props : self.class.props_class.new(**props)
      @validate = validate
      @renderer = self.class.renderer_class.new(self, **renderer_options)
    end

    # @note This method is used when the component is rendered.
    # @see https://guides.rubyonrails.org/layouts_and_rendering.html#rendering-objects
    def render_in(view_context)
      validate_props! if @validate
      view_context.render(renderer)
    end

    # @return [void]
    def validate_props!
      props.validate_json!
    end

    # @return [String]
    def component_name
      ActiveSupport::Inflector.demodulize(self.class.name)
    end
  end
end

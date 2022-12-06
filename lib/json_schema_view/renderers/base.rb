# frozen_string_literal: true

module JsonSchemaView
  module Renderers
    # Render {BaseComponent} in a view.
    # @abstract
    class Base
      # @return [BaseComponent]
      attr_reader :component

      # @param component [BaseComponent] The component to render.
      def initialize(component)
        @component = component
      end

      # Render the React component by using react_on_rails.
      # This method is used by {ActionView::Template::Renderable}.
      #
      # @see https://guides.rubyonrails.org/layouts_and_rendering.html#rendering-objects
      # @param view_content [Object]
      # @return [String]
      def render_in(view_context)
        raise NotImplementedError
      end
    end
  end
end

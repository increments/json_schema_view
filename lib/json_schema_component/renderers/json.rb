# frozen_string_literal: true

require_relative "base"

module JsonSchemaComponent
  module Renderers
    # Render {BaseComponent} as json.
    class Json < Base
      # Render the React component by using react_on_rails.
      # This method is used by {ActionView::Template::Renderable}.
      #
      # @param view_content [Object]
      # @return [String]
      def render_in(view_context)
        view_context.render
        view_context.render(json: component.props.to_json)
      end

      # Returns the content type of the response.
      # This method is used by {ActionView::Template::Renderable}.
      #
      # @return [Symbol]
      def format
        :json
      end
    end
  end
end

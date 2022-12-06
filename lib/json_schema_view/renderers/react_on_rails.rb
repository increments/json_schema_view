# frozen_string_literal: true

require_relative "base"

module JsonSchemaView
  module Renderers
    # Render a React component by using {https://github.com/shakacode/react_on_rails}.
    class ReactOnRails < Base
      # @param view_content [Object]
      # @param options (see ReactOnRailsHelper#react_component)
      # @return [String]
      def render_in(view_context, **options)
        view_context.react_component(component.component_name, props: component.props.as_json, **options)
      end
    end
  end
end

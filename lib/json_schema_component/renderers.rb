# frozen_string_literal: true

module JsonSchemaComponent
  # Renderers module contains classes that render a component.
  module Renderers
    require_relative "renderers/base"
    require_relative "renderers/json"
    require_relative "renderers/react_on_rails"

    # @param name [Symbol]
    def self.find_by_name(name)
      case name
      when :json
        Json
      when :react_on_rails
        ReactOnRails
      else
        raise ArgumentError, "Unknown renderer: #{name}"
      end
    end
  end
end

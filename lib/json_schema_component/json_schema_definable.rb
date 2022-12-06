# frozen_string_literal: true

require "json_world"

require_relative "json_world_extensions"

module JsonSchemaComponent
  # @abstract
  module JsonSchemaDefinable
    extend ActiveSupport::Concern

    include ::JsonWorld::DSL
    include JsonWorldExtensions::Schema202012
    include JsonWorldExtensions::CompactOptionalProperties
    include JsonWorldExtensions::Camelizable
    include JsonWorldExtensions::Validatable

    included do
      additional_properties(false)
    end
  end
end

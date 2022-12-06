# frozen_string_literal: true

require "json_schema_component"

# @abstract
module JsonSchemaDefinable
  extend ActiveSupport::Concern

  include ::JsonSchemaComponent::JsonSchemaDefinable
end

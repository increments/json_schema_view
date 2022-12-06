# frozen_string_literal: true

require "json_schema_view"

# @abstract
module JsonSchemaDefinable
  extend ActiveSupport::Concern

  include ::JsonSchemaView::JsonSchemaDefinable
end

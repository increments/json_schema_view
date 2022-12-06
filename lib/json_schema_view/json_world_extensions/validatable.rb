# frozen_string_literal: true

require "json"
require "json-schema"

module JsonSchemaView
  module JsonWorldExtensions
    # Add method to validate self properties with {JSON::Validator}.
    module Validatable
      # @raise [JSON::Schema::ValidationError] if self is not valid.
      # @return [void]
      def validate_json!
        JSON::Validator.validate!(self.class.as_json_schema, as_json)
      end
    end
  end
end

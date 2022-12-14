# frozen_string_literal: true

require "json_schema_view"

Rails.application.config.autoload_paths += [Rails.root.join("app/components")]

# You can export your components' schemas by running:
# 
#  $ rake json_schema_view:export:primary
Rails.application.config.json_schema_view.schema_sets = {
  "primary": "ComponentSchemaSet",
}

# Validate component with its schema on render.
Rails.application.config.json_schema_view.validate_by_default = true

# frozen_string_literal: true

require "json_schema_component"

Rails.application.config.autoload_paths += [Rails.root.join("app/components")]

# You can export your components' schemas by running:
# 
#  $ rake json_schema_component:export:primary
Rails.application.config.json_schema_component.schema_sets = {
  "primary": "ComponentSchemaSet",
}

# Validate component with its schema on render.
Rails.application.config.json_schema_component.validate_by_default = true

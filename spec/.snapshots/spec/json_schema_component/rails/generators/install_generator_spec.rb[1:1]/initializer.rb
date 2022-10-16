# frozen_string_literal: true

require "json_schema_component"

Rails.application.config.autoload_paths += [Rails.root.join("app/components")]

JsonSchemaComponent.configure do |config|
  # You can export your components' schemas by running:
  # 
  #  $ rake json_schema_component:export:primary
  config.schema_sets = {
    "primary": "ComponentSchemaSet",
  }
end

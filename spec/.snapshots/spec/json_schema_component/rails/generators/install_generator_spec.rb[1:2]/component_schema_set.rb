# frozen_string_literal: true

require "json_schema_component"

# Configure what resource to export its JSON Schema and where directory to export.
class ComponentSchemaSet < ::JsonSchemaComponent::SchemaSet
  # ComponentSchemaSet looks up component classses in this directory.
  def root_path
    __dir__
  end

  # ComponentSchemaSet exports JSON Schema of these component classes.
  def resource_classes_to_export
    [
      # Export all component classes (except for BaseComopnent) in `root_path`.
      *search_component_classes.excluding(BaseComponent),
      # You can add extra classes including {ApiResource} here to export their JSON Schemas.
    ]
  end

  # ComponentSchemaSet exports JSON Schema to this directory.
  def export_path
    Rails.root.join("json_schema")
  end
end

# frozen_string_literal: true

require "rails/generators"

module JsonSchemaComponent
  module Generators
    # Install files to setup json_schema_component gem.
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      class_option :components_path, type: :string, default: "app/components"
      class_option :export_path, type: :string, default: "json_schema"
      class_option :renderer_type, type: :string, default: "react_on_rails"

      def create_initializer
        template "initializer.rb", "config/initializers/json_schema_component.rb"
      end

      def create_base_classes
        template "base_component.rb", File.join(components_path, "base_component.rb")
        template "base_props.rb", File.join(components_path, "base_props.rb")
        template "component_schema_set.rb", File.join(components_path, "component_schema_set.rb")
      end

      def create_exmaples
        template "example/todo_list_component.rb", File.join(components_path, "example_todo_list_component.rb")
        template "example/todo_item_resource.rb",
                 File.join(components_path, "example_todo_list_component", "todo_item_resource.rb")
      end

      private

      def components_path
        options[:components_path]
      end

      def export_path
        options[:export_path]
      end

      def renderer_type
        options[:renderer_type]
      end

      def schema_set_class_name
        "ComponentSchemaSet"
      end
    end
  end
end

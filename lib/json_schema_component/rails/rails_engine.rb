# frozen_string_literal: true

require "rails"

module JsonSchemaComponent
  # :nodoc:
  class RailsEngine < ::Rails::Engine
    rake_tasks do
      load "json_schema_component/rails/tasks/json_schema_component.rake"
    end

    generators do
      require_relative "generators"
    end

    config.before_configuration do
      Rails.application.config.json_schema_component = Configuration.instance
    end
  end
end

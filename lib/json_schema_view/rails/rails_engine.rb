# frozen_string_literal: true

require "rails"

module JsonSchemaView
  # :nodoc:
  class RailsEngine < ::Rails::Engine
    rake_tasks do
      load "json_schema_view/rails/tasks/json_schema_view.rake"
    end

    generators do
      require_relative "generators"
    end

    config.before_configuration do
      Rails.application.config.json_schema_view = Configuration.instance
    end
  end
end

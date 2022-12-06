# frozen_string_literal: true

require "active_support"
require "forwardable"
require "pathname"
require "fileutils"

module JsonSchemaComponent
  # Builder build components
  class SchemaSet
    require_relative "schema_set/constant_search_helper"

    include ConstantSearchHelper

    # @abstract
    # @return [String]
    def root_path
      raise NotImplementedError
    end

    # @abstract
    # @return [String]
    def export_path
      raise NotImplementedError
    end

    # @return [Array<Class<JsonSchemaDefinable>>]
    def resource_classes_to_export
      []
    end

    # @return [void]
    def export_json_schemas(print_logs: false)
      puts "Exports resource classes in #{self.class.name}..." if print_logs
      export_pathname = Pathname.new(export_path)

      exports = resource_classes_to_export.map do |resource_class|
        destination = export_pathname.join("#{resource_class.name.demodulize}.json")
        klass = resource_class < JsonSchemaComponent::BaseComponent ? resource_class.props_class : resource_class

        [destination, resource_class, klass.to_json_schema]
      end

      clear_export_path

      exports.each do |destination, resource_class, json_schema|
        FileUtils.mkdir_p(destination.dirname)
        destination.write(json_schema)
        puts "#{resource_class.name} -> #{destination}" if print_logs
      end
    end

    # @return [void]
    def clear_export_path
      FileUtils.rm_rf(export_path) if Dir.exist?(export_path)
    end
  end
end

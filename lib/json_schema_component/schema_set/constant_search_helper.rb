# frozen_string_literal: true

require "active_support"
require "pathname"

module JsonSchemaComponent
  class SchemaSet
    # Add methods to search constants in the directory to SchemaSet.
    module ConstantSearchHelper
      # @return [Array<Class<BaseComponent>>]
      def search_component_classes(path_pattern: nil)
        constants = path_pattern ? search_constants(path_pattern) : all_constants
        constants.select { |const| const.is_a?(Class) && const < JsonSchemaComponent::BaseComponent }
      end

      # @return [Array<Class, Module>]
      def search_constants(path_pattern: "**/*.rb")
        loader = ConstantAutoLoader.from_rails_app

        root_pathname = Pathname.new(root_path)
        Dir.glob(path_pattern, base: root_path).filter_map do |path|
          path = root_pathname.join(path)
          loader.load_constant_by_path(path)
        end
      end

      # @return [Array<Class, Module>]
      def all_constants
        @all_constants ||= search_constants(path_pattern: "**/*.rb")
      end

      # Load corresponding constant for the path by using Rails's autoloader.
      class ConstantAutoLoader
        # @return [ConstantAutoLoader]
        def self.from_rails_app
          autoload_paths = [
            *Rails.application.config.eager_load_paths,
            *Rails.application.config.autoload_once_paths,
            *Rails.application.config.autoload_paths
          ]

          new(autoload_paths: autoload_paths)
        end

        # @return [Array<Pathname>]
        attr_reader :autoload_paths

        # @param autoload_paths [Array<String>]
        def initialize(autoload_paths:)
          @autoload_paths = autoload_paths.map { |path| Pathname.new(path) }
        end

        # @param path [String, Pathname]
        # @return [Object]
        def load_constant_by_path(path)
          autoload_base_path = nearest_autoload_path(path)
          return nil unless autoload_base_path

          rel_path = child_path(path, autoload_base_path)
          return nil unless rel_path

          ActiveSupport::Inflector.safe_constantize(constant_name_from_path(rel_path))
        end

        private

        # @param path [Pathname]
        # @return [String]
        def constant_name_from_path(path)
          path = remove_extname(path)
          classified = ActiveSupport::Inflector.classify(path.to_s)

          # Make absolute constant path
          if classified.start_with?("::")
            classified == "::" ? "::Object" : classified
          else
            "::#{classified}"
          end
        end

        # @param path [Pathname]
        # @return [Pathname]
        def remove_extname(path)
          # Repeat for the case of multiple extensions (e.g. .min.rb)
          until path.extname.empty?
            removed = path.to_s.delete_suffix(path.extname)
            path = Pathname.new(removed)
          end

          path
        end

        # @param path [String]
        # @return [Pathname, nil]
        def nearest_autoload_path(path)
          matches = autoload_paths.filter_map do |autoload_path|
            rel_path = child_path(path, autoload_path)
            rel_path && [autoload_path, rel_path]
          end
          matches.min_by { |(_autoload_path, rel_path)| rel_path.to_s.length }&.first
        end

        # @param path [Pathname]
        # @param dir_path [Pathname]
        # @return [Pathname, nil]
        def child_path(path, base_dir_path)
          path = Pathname.new(path).realpath
          relative_path = path.relative_path_from(base_dir_path)
          relative_path.to_s.start_with?("../") ? nil : relative_path
        end
      end
    end
  end
end

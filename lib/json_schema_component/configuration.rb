# frozen_string_literal: true

module JsonSchemaComponent
  # The singleton holds the configuration for the gem.
  # it can be accessed by both its class methods and Rails's configuration.
  class Configuration
    require_relative "configuration/schema_set_dictionary"

    class << self
      # @return [JsonSchemaComponent::Configuration]
      def instance
        @instance ||= new
      end

      # @yield [configuration]
      # @yieldparam configuration [JsonSchemaComponent::Configuration]
      def configure(&block)
        instance.configure(&block)
      end
    end

    def initialize
      @schema_sets = SchemaSetDictionary.new
      @validate_by_default = false
    end

    # @return [SchemaSetDictionary{Symbol => Symbol}] The renderers.
    attr_reader :schema_sets

    # @return [Boolean] Whether if validate components with its schema on render by default.
    attr_accessor :validate_by_default

    # @param new_sets [Hash{String, Symbol => String, Symbol}]
    def schema_sets=(new_sets)
      @schema_sets = SchemaSetDictionary.new(new_sets)
    end

    # @yield [configuration]
    # @yieldparam configuration [JsonSchemaComponent::Configuration]
    def configure
      yield self
    end
  end
end

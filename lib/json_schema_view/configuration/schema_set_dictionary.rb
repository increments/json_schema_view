# frozen_string_literal: true

require "delegate"

module JsonSchemaView
  class Configuration
    # :nodoc:
    class SchemaSetDictionary < Delegator
      attr_reader :hash

      # @param contents [Hash, nil]
      def initialize(contents = nil)
        @hash = ActiveSupport::HashWithIndifferentAccess.new(contents)
        super
      end

      # @overload {Delegator#__getobj__}
      # @return [HashWithIndifferentAccess{Symbol => Symbol}]
      def __getobj__
        hash
      end

      # @overload {Delegator#__setobj__}
      def __setobj__(_)
        # noop
      end

      # @param key [#to_sym] The alias name of SchemaSet
      # @param value [String, Symbol] The name of SchemaSet class
      def []=(key, value)
        raise TypeError, "key (#{key}) cannot be converted to a symbol" unless key.respond_to?(:to_sym)

        if !value.is_a?(String) && !value.is_a?(Symbol)
          raise TypeError,
                "value (#{value}) must be the name of SchemaSet class"
        end

        hash[key.to_sym] = value.to_sym
      end

      # @return [SchemaSet]
      def fetch_instance(key)
        klass = fetch(key).constantize

        raise TypeError, "#{klass} is not the name of SchemaSet class" unless klass < JsonSchemaView::SchemaSet

        klass.new
      end
    end
  end
end

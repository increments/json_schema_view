# frozen_string_literal: true

begin
  require "rails"
  require_relative "rails/rails_engine"
rescue LoadError
  # Skip loading modules about rails if Rails is not available.
end

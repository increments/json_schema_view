# frozen_string_literal: true

require "fileutils"

module GeneratorSpecHelper
  extend ActiveSupport::Concern

  included do
    destination File.expand_path("../../../tmp/generator_destination", __dir__)

    before { prepare_destination }
  end

  def file_content(rel_path)
    File.read(file(rel_path))
  end
end

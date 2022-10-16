# frozen_string_literal: true

require "fileutils"

module MatchSnapshot
  class << self
    attr_accessor :current_example_id
  end
end

# Compare the input with the specified snapshot.
# You can update snapshot if `UPDATE_SNAPSHOT` environment variable is set.
RSpec::Matchers.define(:match_snapshot) do |snapshot_key|
  snapshot_key = snapshot_key.to_s

  match do |actual|
    if write_to_snapshot?
      FileUtils.mkdir_p(File.dirname(snapshot_path))
      File.write(snapshot_path, actual)

      puts "Wrote snapshot: #{snapshot_path}"

      # Make success when writing to snapshot
      true
    else
      actual == snapshot
    end
  end

  description do
    "matches snapshot #{snapshot_key}"
  end

  diffable

  # @note This method is used to show the expected value in diff view.
  def expected
    snapshot
  end

  def snapshot
    @snapshot ||= File.exist?(snapshot_path) ? File.read(snapshot_path) : ""
  end

  define_method(:snapshot_key) do
    snapshot_key
  end

  def snapshot_file_path
    File.join(MatchSnapshot.current_example_id, snapshot_key)
  end

  def snapshot_path
    # Use `RSpec::Core::Example.id` and the given key for the snapshot path.
    File.expand_path(snapshot_file_path, File.expand_path("../../.snapshots", __dir__))
  end

  def write_to_snapshot?
    ENV["UPDATE_SNAPSHOT"] && !ENV["UPDATE_SNAPSHOT"].empty?
  end
end

RSpec.configure do |config|
  config.around(:each) do |example|
    MatchSnapshot.current_example_id = example.id
    example.run
  end
end

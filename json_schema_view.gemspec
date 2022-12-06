# frozen_string_literal: true

require_relative "lib/json_schema_view/version"

Gem::Specification.new do |spec|
  spec.name = "json_schema_view"
  spec.version = JsonSchemaView::VERSION
  spec.authors = ["Tomoya Chiba"]
  spec.email = ["tomo.asleep@gmail.com"]
  spec.license = "Apache-2.0"

  spec.summary = "A view library with JSON Schema"
  spec.description = "A view library with JSON Schema"
  spec.homepage = "https://github.com/increments/json_schema_view"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/increments/json_schema_view/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "activesupport"
  spec.add_dependency "json-schema"
  spec.add_dependency "json_world"

  # Don't write development dependencies here. Add to Gemfile instead.

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

# frozen_string_literal: true

require "json_schema_component/rails/generators"

require "support/matchers/match_snapshot"
require "support/helpers/generator_spec_helper"

RSpec.describe JsonSchemaComponent::Generators::InstallGenerator, type: :generator do
  include GeneratorSpecHelper

  subject { run_generator }

  it "generates initializer" do
    subject
    expect(file_content("config/initializers/json_schema_component.rb")).to match_snapshot("initializer.rb")
  end

  it "setups components dir" do
    subject
    expect(file_content("app/components/base_component.rb")).to match_snapshot("base_component.rb")
    expect(file_content("app/components/base_props.rb")).to match_snapshot("base_props.rb")
    expect(file_content("app/components/component_schema_set.rb")).to match_snapshot("component_schema_set.rb")
  end

  it "generates an example of component" do
    subject
    expect(file_content("app/components/example_todo_list_component.rb")).to match_snapshot("todo_list_component.rb")
    expect(file_content("app/components/example_todo_list_component/todo_item_resource.rb")).to match_snapshot("todo_item_resource.rb")
  end
end

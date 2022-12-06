# frozen_string_literal: true

namespace :json_schema_view do
  desc "Export json schemas in the specified schema set"
  task :export, [:schema_set] => [:environment] do |_task, args|
    schema_set = JsonSchemaView.configuration.schema_sets.fetch_instance(args[:schema_set])
    schema_set.export_json_schemas(print_logs: true)
  end
end

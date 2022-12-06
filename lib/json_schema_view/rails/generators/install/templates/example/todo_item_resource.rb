# frozen_string_literal: true

require "json_schema_view"

class ExampleTodoListComponent
  # This is an example definition of a resource.
  #
  # A class that includes {JsonSchemaView::JsonSchemaDefinable} can generate its JSON Schema
  # and it can be used as a type in another resource's property.
  class TodoItemResource
    include JsonSchemaView::JsonSchemaDefinable

    property(
      :name,
      description: "The title of TODO item.",
      type: String,
    )

    property(
      :done,
      description: "Whether the TODO item is done or not.",
      type: [TrueClass, FalseClass],
    )

    property(
      :note,
      description: "The additional description of TODO item.",
      type: String,
      optional: true,
    )

    # @param todo_item [Hash] A todo item ({ name: String, done: Boolean, note: String or nil }).
    def initialize(todo_item)
      @todo_item = todo_item
    end

    # @return [String] The title of TODO item.
    def title
      @todo_item[:title]
    end

    # @return [Boolean] Whether the TODO item is done or not.
    def done
      @todo_item[:done]
    end

    # @param note [String, nil] The additional description of TODO item.
    def note
      @todo_item[:note]
    end
  end
end

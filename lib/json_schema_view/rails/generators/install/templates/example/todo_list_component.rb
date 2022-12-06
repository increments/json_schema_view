# frozen_string_literal: true

require "json_schema_view"

# This is an example definition of a component.
#
# @example You can use this component in a view like following code:
#   todo_items = [{ title: "Buy milk", done: false }, { title: "Buy eggs", done: true, note: "Large eggs are better" }]
#   render ExampleTodoListComponent.new(props: { todo_items: todo_items })
#
# @example Extract the JSON Schema of this component:
#   ExampleTodoListComponent.props_class.to_json_schema
#   # => {
#     "properties": {
#       "type": "array",
#       "items": {
#         "type": "object",
#         "properties": {
#           "name": {
#             "description": "The title of TODO item.",
#             "type": "string"
#           },
#           "done": {
#             "description": "Whether the TODO item is done or not.",
#             "type": ["boolean"]
#           },
#           "note": {
#             "description": "The additional description of TODO item.",
#             "type": ["string"]
#           }
#         },
#         "required": ["name", "done"],
#         "additionalProperties": false
#       }
#     }
#     "required": ["todo_items"],
#     "additionalProperties": false
#   }
#
class ExampleTodoListComponent < BaseComponent
  # props_class defines the properties class for the component.
  # properties class is a special form of {JsonSchemaDefinable}. its instance is used by renderer to render component's content.
  props_class do
    # Some class methods (properties, description, additional_properties, etc.) are provided to define the JSON Schema of the class.
    # Property
    #
    # @see https://json-schema.org/understanding-json-schema/reference/object.html#properties
    property(
      :todo_items,
      # To type keyword, you can pass some primitive classes (String, Integer, TrueClass, Array, ...etc), a hash representing JSON Schema, an {JsonSchemaDefinable}.
      type: Array,
      item: {
        type: TodoItemResource
      },
    )

    # @param todo_items [Array<Hash>] An array of todo items ({ name: String, done: Boolean, note: String or nil }).
    def initialize(todo_items:)
      @todo_items = todo_items
    end

    # @return [Array<ExampleTodoItemResource>]
    def todo_items
      @todo_items.map { |todo_item| ExampleTodoItemResource.new(todo_item) }
    end
  end
end

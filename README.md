# JsonSchemaComponent

JsonSchemaComponent is a view framework that brings Schema-driven Development to Rails view and another view frameworks (e.g react_on_rails).

JsonSchemaComponent is a Ruby object:

```ruby
class TodoItemComponent < JsonSchemaComponent::BaseComponent
  renderer_class :react_on_rails

  props_class do
    property :title, type: String
    property :done, type: [TrueClass, FalseClass]

    attr_reader :title, :done

    def initialize(title:, done:)
      @title = title
      @done = done
    end
  end
end
```

The component can be passed to Rails' `render` and then its schema validates its props:

```ruby
render TodoItemComponent.new(props: { title: 'Buy milk', done: false }) # => Valid against schema. Renders a view by using renderer (react_on_rails)

render TodoListComponent.new(props: { title: 'Buy milk', done: "Invalid value" }) # => Invalid. Raises an error.
```

The component's schema can be exported as JSON Schema:

```json5
// TodoItemComponent.to_json_schema
{
  "type": "object",
  "properties": {
    "title": {
      "type": "string"
    },
    "done": {
      "type": "boolean"
    }
  },
  "required": ["title", "done"],
  "additional_properties": false
}
```

Its JSON Schema can be used to generate type definitions for other languages.
It helps consistent typing between different languages:

```jsx
import type { TodoItemComponentProps } from './generated-types-from-json-schema/TodoItemComponent';

export const TodoItemComponent = ({ title, done }: TodoItemComponentProps) => {
  return (
    <div>
      <input type="checkbox" checked={done} />
      <label>{title}</label>
    </div>
  );
};
```

## Getting Started
### Installation

1. Install the gem and add to the application's Gemfile by executing:

```console
$ bundle add json_schema_component
```

2. Run the generator:

```console
$ bin/rails generate json_schema_component:install
    create  config/initializers/json_schema_component.rb
    create  app/components/base_component.rb
    create  app/components/base_props.rb
    create  app/components/api_resource.rb
    create  app/components/component_schema_set.rb
    create  app/components/example_todo_list_component.rb
    create  app/components/example_todo_list_component/todo_item_resource.rb
```

This task sets up `app/components` as the place of component definitions and an example component :-)


### Export JSON Schema

JsonSchemaComponent provides a rake task to export JSON Schema of components:

```console
$ rake json_schema_component:export[primary]
Exports resource classes in ComponentSchemaSet...
ExampleTodoListComponent -> /path/to/rails/application/json_schema/ExampleTodoListComponent.json
```

The behavior of the export task (output directory, classes to export, ...etc) can be configured on ComponentSchemaSet.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/increments/json_schema_component. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/increments/json_schema_component/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the JsonSchemaComponent project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/increments/json_schema_component/blob/main/CODE_OF_CONDUCT.md).

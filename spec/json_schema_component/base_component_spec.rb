# frozen_string_literal: true

require "nokogiri"
require "react_on_rails"

module JsonSchemaViewTesting
end

RSpec.describe JsonSchemaView::BaseComponent do
  let(:component_class) { Class.new(described_class) }

  describe ".props_class" do
    context "without block argument" do
      subject { component_class.props_class }

      it "defines a props class and returns it" do
        expect(subject).to be < JsonSchemaView::BaseProps
        expect(subject).to be(component_class::Props)
      end
    end

    context "with block argument" do
      subject do
        component_class.props_class do
          def some_method; end
        end
      end

      it "defines a props class and returns it" do
        expect(subject).to be < JsonSchemaView::BaseProps
        expect(subject).to be(component_class::Props)

        expect(subject).to be_method_defined(:some_method)
      end
    end
  end

  describe "#props" do
    subject { component_class_instance.props }

    let(:component_class_instance) { component_class.new(props: { key1: "value1", key2: "value2" }) }

    before do
      component_class.class_eval do
        renderer_class :json
      end

      component_class.props_class do
        attr_reader :key1, :key2

        def initialize(key1:, key2:)
          @key1 = key1
          @key2 = key2
        end
      end
    end

    it "is assigned props on initialization" do
      expect(subject).to have_attributes(key1: "value1", key2: "value2")
    end
  end

  describe "#render_in" do
    shared_context "controller testing" do
      let(:request) { ActionDispatch::TestRequest.create }
      let(:controller_class) do
        Class.new(ActionController::Base).extend(ReactOnRails::Controller).extend(ReactOnRails::Helper)
      end
      let(:controller) do
        controller_class.new.tap { |c| c.request = request }
      end

      before do
        ActionView::Base.include(ReactOnRails::Helper)
      end
    end
    include_context "controller testing"

    subject { component_class_instance.render_in(controller.view_context) }

    let(:dom) { Nokogiri::HTML(subject) }

    before do
      JsonSchemaViewTesting::TestComponent = component_class

      component_class.class_eval do
        renderer_class :react_on_rails
      end

      component_class.props_class do
        property(:key1, type: String)
        property(:key2, type: String)

        attr_reader :key1, :key2

        def initialize(key1:, key2:)
          @key1 = key1
          @key2 = key2
        end
      end
    end

    after do
      JsonSchemaViewTesting.module_eval do
        remove_const(:TestComponent) if const_defined?(:TestComponent)
      end
    end

    context "when proper props are given" do
      let(:component_class_instance) { component_class.new(props: { key1: "value1", key2: "value2" }) }

      it "renders the component by using react on rails" do
        script_tag = dom.css("body > script.js-react-on-rails-component").first

        expect(script_tag).to be_present
        expect(script_tag.get_attribute("data-component-name")).to eq("TestComponent")
        expect(JSON.parse(script_tag.child)).to a_hash_including("key1" => "value1", "key2" => "value2")
      end
    end

    context "when wrong props are given" do
      let(:component_class_instance) { component_class.new(props: { key1: "value1", key2: 1 }) }

      it "fails with validation error" do
        expect { subject }.to raise_error(JSON::Schema::ValidationError)
      end
    end
  end
end

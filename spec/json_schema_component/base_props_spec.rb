# frozen_string_literal: true

RSpec.describe JsonSchemaComponent::BaseProps do
  let(:props_class) { Class.new(described_class) }

  describe "#as_json" do
    subject { instance.as_json }

    context "when camelizations of some fields are enabled" do
      let(:instance) do
        props_class.new(camelized_key: "value1", not_camelized_key: "value2", not_specified_key: "value3")
      end

      before do
        props_class.class_eval do
          property(:camelized_key, camelize: true)
          property(:not_camelized_key, camelize: false)
          property(:not_specified_key)

          attr_reader :camelized_key, :not_camelized_key, :not_specified_key

          def initialize(camelized_key:, not_camelized_key:, not_specified_key:)
            @camelized_key = camelized_key
            @not_camelized_key = not_camelized_key
            @not_specified_key = not_specified_key
          end
        end
      end

      it "returns a hash with camelized keys" do
        expect(subject).to eq("camelizedKey" => "value1", "not_camelized_key" => "value2",
                              "notSpecifiedKey" => "value3")
      end
    end

    context "when some key is optional and its value is nil" do
      let(:instance) { props_class.new(optional_key: nil, not_optional_key: nil) }

      before do
        props_class.class_eval do
          property(:optional_key, optional: true, camelize: false)
          property(:not_optional_key, optional: false, camelize: false)

          attr_reader :optional_key, :not_optional_key

          def initialize(optional_key:, not_optional_key:)
            @optional_key = optional_key
            @not_optional_key = not_optional_key
          end
        end
      end

      it "returns a hash with camelized keys" do
        expect(subject).to eq("not_optional_key" => nil)
        expect(subject).to have_key("not_optional_key")
        expect(subject).not_to have_key("optional_key")
      end
    end
  end
end

require "spec_helper"
require_relative "../../app/actions/validate_input_parameters"

describe ValidateInputParameters do
  let(:valid_params) { { filename: "Gemfile" } }
  let(:invalid_params) { { filename: "Rakefile"} }

  describe "#validate" do
    it "returns true if parameters are valid" do
      action = ValidateInputParameters.new(valid_params)

      action.validate.should be_true
    end

    it "returns false if parameters are invalid" do
      action = ValidateInputParameters.new(invalid_params)

      action.validate.should be_false
    end

    it "returns false if parameters are empty" do
      action = ValidateInputParameters.new(nil)

      action.validate.should be_false
    end
  end
end
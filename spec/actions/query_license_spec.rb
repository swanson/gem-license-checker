require "spec_helper"
require_relative "../../app/actions/query_licenses"

describe QueryLicenses do
  let(:dependenices) do
    [
      stub(name: "rails", requirement: ">= 0")
    ]
  end

  describe "#query" do
    before do
      GemRepository.stub(:get_license_by_name)
        .with("rails")
        .and_return("MIT")
    end

    it "returns list of results" do
      action = QueryLicenses.new(dependenices)

      results = action.query

      results.size.should eq 1
      results.first.name.should eq "rails"
      results.first.version.should eq ">= 0"
      results.first.license.should eq "MIT"
    end
  end
end
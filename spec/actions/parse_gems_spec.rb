require "spec_helper"
require_relative "../../app/actions/parse_gems"

describe ParseGems do
  let(:gemfile) { 
    Rack::Test::UploadedFile.new("spec/test_files/Gemfile", "text/text")
  }
  
  describe "#parse" do
    it "returns a list of gems from the file" do
      gems = ParseGems.new(gemfile).parse

      gems.size.should eq 2
      gems.first.name.should eq "sinatra"
      gems.last.name.should eq "rake"
    end
  end
end
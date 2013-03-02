class ParseGems
  attr_reader :contents

  def initialize(file_handle)
    @contents = file_handle.read
  end

  def parse
    Gemnasium::Parser::Gemfile.new(contents).dependencies
  end
end
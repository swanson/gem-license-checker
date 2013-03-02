ENV['RACK_ENV'] = 'test'

Bundler.require :default, :development, :test

set :raise_errors, true
set :logging, false

require File.join(File.dirname(__FILE__), '../app')

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.color_enabled = true
end
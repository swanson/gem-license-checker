require "sinatra/base"
require "sinatra/activerecord"

require_relative "app/models/gems"
require_relative "app/models/license"

class GemLicenseChecker < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    set :database_file, "config/database.yml"
  end

  get "/" do 
    "hello world"
  end
end
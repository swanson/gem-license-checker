require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/flash"

require_relative "app/models/project_gem"
require_relative "app/models/license"

require_relative "app/actions/validate_input_parameters"
require_relative "app/actions/parse_gems"
require_relative "app/actions/query_licenses"

class GemLicenseChecker < Sinatra::Base
  configure do
    set :database_file, "config/database.yml"
    set :views, "app/views"

    enable :sessions
    set :session_secret, "secret!"

    register Sinatra::ActiveRecordExtension
    register Sinatra::Flash
  end

  helpers do
    # allow for partials using this syntax
    # = render partial: :foo
    def render(*args)
      if args.first.is_a?(Hash) && args.first.keys.include?(:partial)
        return haml "partials/_#{args.first[:partial]}".to_sym, :layout => false
      else
        super
      end
    end
  end

  get "/" do 
    haml :index
  end

  post "/upload" do
    action = ValidateInputParameters.new(params[:gemfile_upload])

    if action.validate
      dependencies = ParseGems.new(params[:gemfile_upload][:tempfile]).parse
      @results = QueryLicenses.new(dependencies).query
      haml :results
    else
      flash[:error] = "Gemfile only please"
      redirect to("/")
    end
  end
end
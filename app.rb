require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/flash"

require_relative "app/models/project_gem"
require_relative "app/models/license"

require_relative "app/actions/validate_input_parameters"
require_relative "app/actions/parse_gems"
require_relative "app/actions/query_licenses"
require_relative "app/actions/fetch_license"

require_relative "app/repositories/gem_repository"
require_relative "app/repositories/result_repository"

class GemLicenseChecker < Sinatra::Base
  configure do
    set :database_file, "config/database.yml"
    set :views, "app/views"
    set :public, "app/public"

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
      
      queue_up_unknown_gems(dependencies)

      r = ResultRepository.save(dependencies)
      
      redirect to("/results/#{r.hash_id}")
      haml :results
    else
      flash[:error] = "Please upload a Gemfile."
      redirect to("/")
    end
  end

  get "/results/:id" do
    result = ResultRepository.find(params[:id])

    @results = QueryLicenses.new(result.gem_list).query

    haml :results
  end

  def queue_up_unknown_gems(dependencies)
    dependencies.each do |dep|
      unless GemRepository.exists?(dep.name)
        FetchLicense.new(dep.name).delay.fetch
      end
    end
  end
end
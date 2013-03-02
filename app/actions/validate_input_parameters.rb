class ValidateInputParameters
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def validate
    params and params[:filename] and params[:filename] == "Gemfile"
  end
end
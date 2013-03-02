require_relative "../models/result"
require_relative "../repositories/gem_repository"

class QueryLicenses
  attr_reader :dependencies

  def initialize(dependencies)
    @dependencies = dependencies
  end

  def query
    results = []
    @dependencies.each do |dep|
      license = GemRepository.get_license_by_name(dep.name)
      results << Result.new(dep.name, dep.requirement, license)
    end
    results
  end
end
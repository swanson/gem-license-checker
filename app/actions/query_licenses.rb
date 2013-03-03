require_relative "../models/gem_result"
require_relative "../repositories/gem_repository"

class QueryLicenses
  attr_reader :gem_names

  def initialize(gem_names)
    @gem_names = gem_names
  end

  def query
    results = []
    @gem_names.each do |gem_name|
      exists = GemRepository.exists?(gem_name)
      if exists
        license = GemRepository.get_license_by_name(gem_name)
        results << GemResult.new(gem_name, license)
      else
        results << GemResult.new(gem_name, "Checking...")
      end
    end
    results
  end
end
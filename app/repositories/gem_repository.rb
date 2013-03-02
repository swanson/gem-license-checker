require_relative "../models/project_gem"

class GemRepository
  def self.get_license_by_name(gem_name)
    g = ProjectGem.where(name: gem_name).first

    if g and !g.license.nil?
      g.license.name
    else
      "Unknown"
    end 
  end
end
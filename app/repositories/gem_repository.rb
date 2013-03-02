require_relative "../models/gems"

class GemRepository
  def find(id)
    Gems.find(id)
  end

  def all
    Gems.all
  end
end
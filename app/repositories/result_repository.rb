require_relative "../models/result"

class ResultRepository
  def self.save(gem_list)
    gems = gem_list.map{|g| g.name}.join("|")
    Result.create(hash_id: SecureRandom.hex, gems: gems)
  end

  def self.find(hash_id)
    Result.where(hash_id: hash_id).first
  end
end
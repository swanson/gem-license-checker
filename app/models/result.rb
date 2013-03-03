class Result < ActiveRecord::Base
  def gem_list
    gems.split("|")
  end
end
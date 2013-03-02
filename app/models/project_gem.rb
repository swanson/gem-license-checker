class ProjectGem < ActiveRecord::Base
  ProjectGem.table_name = :gems # Break naming conventions because of collision with Gem/Gems modules

  belongs_to :license
end
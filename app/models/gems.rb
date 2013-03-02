class Gems < ActiveRecord::Base
  set_table_name :gems # Break naming conventions because of collision with Gem module
end
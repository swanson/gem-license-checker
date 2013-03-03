class AddResults < ActiveRecord::Migration
  def change
    create_table :results, :id => false do |t|
      t.string :hash_id
      t.text :gems
      t.timestamps
    end
  end
end

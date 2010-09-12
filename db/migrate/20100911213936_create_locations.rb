class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
    	t.string :name
    	t.decimal :lat, :lng
      	t.timestamps
    end
    add_index :locations, [:lat, :lng]
  end

  def self.down
    drop_table :locations
  end
end

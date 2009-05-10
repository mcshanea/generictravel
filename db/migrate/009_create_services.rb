class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :venue
      t.string :operator
      t.text :description
      
      t.string :phone_number
      t.string :fax_number
      
      t.integer :location_id

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end

class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.text :address
      t.string :post_code
      t.string :country
      
      t.string :address_type
      
      t.integer :agent_id, :service_id, :client_id

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end

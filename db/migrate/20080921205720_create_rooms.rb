class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :room_type
      t.integer :hotel_id
      t.float :rate
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end

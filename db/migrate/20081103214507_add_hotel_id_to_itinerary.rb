class AddHotelIdToItinerary < ActiveRecord::Migration
  def self.up
    add_column :itineraries, :hotel_id, :integer
    add_column :itineraries, :room_id, :integer
  end

  def self.down
    remove_column :itineraries, :hotel_id
    remove_column :itineraries, :room_id
  end
end

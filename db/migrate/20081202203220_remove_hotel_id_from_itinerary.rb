class RemoveHotelIdFromItinerary < ActiveRecord::Migration
  def self.up
    remove_column :itineraries, :hotel_id
    remove_column :itineraries, :room_id
  end

  def self.down
    add_column :itineraries, :hotel_id, :integer
    add_column :itineraries, :room_id, :integer
  end
end

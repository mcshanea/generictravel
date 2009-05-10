class AddRateIdToItinerary < ActiveRecord::Migration
  def self.up
    add_column :itineraries, :rate_id, :integer
  end

  def self.down
    remove_column :itineraries, :rate_id
  end
end

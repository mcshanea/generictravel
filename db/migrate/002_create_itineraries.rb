class CreateItineraries < ActiveRecord::Migration
  def self.up
    create_table :itineraries do |t|
      t.string :itinerary_type
      t.string :departing, :arriving
      t.date :arrival_date
      t.date :departure_date
      t.string :operator
      t.integer :booking_id
      t.string :booking_reference

      t.timestamps
    end
  end

  def self.down
    drop_table :itineraries
  end
end

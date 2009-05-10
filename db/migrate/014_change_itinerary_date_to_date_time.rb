class ChangeItineraryDateToDateTime < ActiveRecord::Migration
  def self.up
     change_column :itineraries, :departure_date, :datetime
     change_column :itineraries, :arrival_date, :datetime
  end

  def self.down
     change_column :itineraries, :departure_date, :date
     change_column :itineraries, :arrival_date, :date
  end
end

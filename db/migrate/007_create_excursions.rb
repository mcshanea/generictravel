class CreateExcursions < ActiveRecord::Migration
  def self.up
    create_table :excursions do |t|
      t.string :duration
      t.date :arrival_date
      t.date :departure_date
      t.integer :service_id
      t.integer :booking_id
      t.string :booking_reference

      t.timestamps
    end
  end

  def self.down
    drop_table :excursions
  end
end

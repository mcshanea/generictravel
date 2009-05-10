class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.integer :agent_id
      t.string :departing
      t.string :arriving
      t.string :status
      t.date :sent_date
      
      t.integer :payment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end

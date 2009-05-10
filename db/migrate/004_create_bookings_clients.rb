class CreateBookingsClients < ActiveRecord::Migration
  def self.up
    create_table :bookings_clients, :id => false do |t|
      t.integer :booking_id
      t.integer :client_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bookings_clients
  end
end

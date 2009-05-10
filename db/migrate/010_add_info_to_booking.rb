class AddInfoToBooking < ActiveRecord::Migration
  def self.up
    add_column :bookings, :info, :text
  end

  def self.down
    remove_column :bookings, :info
  end
end

class AddLeaderIdToBooking < ActiveRecord::Migration
  def self.up
    add_column :bookings, :leader_id, :integer
  end

  def self.down
    remove_column :bookings, :leader_id
  end
end

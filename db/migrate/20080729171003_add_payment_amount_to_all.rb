class AddPaymentAmountToAll < ActiveRecord::Migration
  def self.up
    add_column :bookings, :agent_percentage, :int
    add_column :itineraries, :payment_amount, :float
    add_column :excursions, :payment_amount, :float
  end

  def self.down
    remove_column :bookings, :agent_percentage
    remove_column :itineraries, :payment_amount
    remove_column :excursions, :payment_amount
  end
end

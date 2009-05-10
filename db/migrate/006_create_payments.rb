class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.float :value
      t.string :payment_type
      t.date :processed_date
      
      t.integer :booking_id

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end

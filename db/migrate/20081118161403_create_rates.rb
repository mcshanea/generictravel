class CreateRates < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
      t.float :amount
      t.date :start_date
      t.date :end_date
      t.integer :room_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rates
  end
end

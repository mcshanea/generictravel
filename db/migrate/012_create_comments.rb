class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :booking_id
      t.integer :agent_id
      t.text :value

      t.timestamps
    end
    
    add_column :bookings, :comment_id, :integer
    add_column :agents, :comment_id, :integer
  end

  def self.down
    drop_table :comments
    
    remove_column :bookings, :comment_id
    
    remove_column :agents, :comment_id
  end
end

class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :telephone
      t.string :mobile
      
      t.boolean :primary

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end

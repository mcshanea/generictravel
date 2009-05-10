class CreateAgents < ActiveRecord::Migration
  def self.up
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.string :telephone
      t.string :mobile
      t.boolean :active
      
      t.string :role

      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      
      t.timestamps
    end
  end

  def self.down
    drop_table :agents
  end
end

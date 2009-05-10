class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.integer :licences
      t.boolean :active

      t.timestamps
    end
    
    add_column :agents, :company_id, :integer
    
    add_column :bookings, :company_id, :integer
    
    add_column :clients, :company_id, :integer
  end

  def self.down
    drop_table :companies
    
    remove_column :agents, :company_id
    
    remove_column :bookings, :company_id
    
    remove_column :clients, :company_id
  end
end

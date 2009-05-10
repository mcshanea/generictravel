class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.string :departing
      t.string :arriving
      t.string :status
      t.date :from
      t.date :to
      t.integer :service_id
      t.integer :agent_id
      t.integer :client_id

      t.timestamps
    end
  end

  def self.down
    drop_table :searches
  end
end

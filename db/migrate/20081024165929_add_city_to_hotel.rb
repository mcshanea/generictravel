class AddCityToHotel < ActiveRecord::Migration
  def self.up
    add_column :hotels, :city, :string
  end

  def self.down
    remove_column :hotels, :city
  end
end

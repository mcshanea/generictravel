class AddCompanyIdToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :company_id, :integer
  end

  def self.down
    remove_column :services, :company_id
  end
end

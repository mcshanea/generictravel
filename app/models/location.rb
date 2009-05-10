class Location < ActiveRecord::Base
  belongs_to :agent
  belongs_to :client
  belongs_to :service
  
  belongs_to :hotel
  
  ADDRESS_TYPE = ["BILLING", "DELIVERY","ABROAD"]
  
  attr_accessor :hotel_id
  attr_accessor :company_id
end

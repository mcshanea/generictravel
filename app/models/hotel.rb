class Hotel < ActiveRecord::Base
  has_many :rooms
  
  has_one :location
  
  CITIES = YAML::load(File.open("#{RAILS_ROOT}/config/hotel_cities.yml"))
end

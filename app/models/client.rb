class Client < ActiveRecord::Base
  has_and_belongs_to_many :bookings
  has_many :locations, :dependent => :destroy
  
  #validates_presence_of :bookings
  
  after_update :save_locations
  
  def new_location_attributes=(location_attributes)
    location_attributes.each do |attributes|
      locations.build(attributes)
    end
  end

  def existing_location_attributes=(location_attributes)
    locations.reject(&:new_record?).each do |location|
      attributes = location_attributes[location.id.to_s]
      if attributes
        location.attributes = attributes
      else
        locations.delete(location)
      end
    end
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end

  private
  
  def save_locations
    locations.each do |location|
      location.save(false)
    end
  end
  
end

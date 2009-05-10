class Service < ActiveRecord::Base
  has_many :locations, :dependent => :destroy
  has_many :excursions
  
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

  private
  
  def save_locations
    locations.each do |location|
      location.save(false)
    end
  end
end

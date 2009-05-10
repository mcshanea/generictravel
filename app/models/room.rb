class Room < ActiveRecord::Base
  belongs_to :hotel
  has_many :rates
  
  after_update :save_rates
  
  def room_with_rate
    "#{room_type} - #{rate}"
  end
  
  def new_rate_attributes=(rate_attributes)
    rate_attributes.each do |attributes|
      rates.build(attributes)
    end
  end

  def existing_rate_attributes=(rate_attributes)
    rates.reject(&:new_record?).each do |rate|
      attributes = rate_attributes[rate.id.to_s]
      if attributes
        rate.attributes = attributes
      else
        rates.delete(rate)
      end
    end
  end
  
  private
  
  def save_rates
    rates.each do |rate|
      rate.save(false)
    end
  end
end

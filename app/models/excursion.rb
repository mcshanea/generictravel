class Excursion < ActiveRecord::Base
  belongs_to :service
  belongs_to :booking
  
  validates_presence_of :booking, :service
  
  formatted_time_accessor :departure_date, :arrival_date
  
  attr_accessor :should_destroy
  
  def should_destroy?
    should_destroy.to_i == 1
  end
end

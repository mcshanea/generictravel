class Payment < ActiveRecord::Base
  belongs_to :booking
  
  validates_presence_of :booking
  
  attr_accessor :processed, :should_destroy
  
  formatted_time_accessor :processed_date
  
  PAYMENT_TYPES = YAML::load(File.open("#{RAILS_ROOT}/config/payment_types.yml"))
  
  def before_save
    if :processed? 
      payment.processed_date = Time.now
    end
  end
  
  def processed?
    processed.to_i == 1
  end
  
  def should_destroy?
    should_destroy.to_i == 1
  end
end

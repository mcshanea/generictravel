require 'googlecalendar'

class Booking < ActiveRecord::Base
  has_and_belongs_to_many :clients
  
  has_many :itineraries, :dependent => :destroy
  has_many :excursions, :dependent => :destroy
  belongs_to :agent
  
  has_many :payments, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  validates_presence_of :company_id
  
  after_update :save_itineraries, :save_excursions, :save_comments
  
  STATUS = YAML::load(File.open("#{RAILS_ROOT}/config/booking_status.yml"))
  
  def new_itinerary_attributes=(itinerary_attributes)
    itinerary_attributes.each do |attributes|
      itineraries.build(attributes)
    end
  end

  def existing_itinerary_attributes=(itinerary_attributes)
    itineraries.reject(&:new_record?).each do |itinerary|
      attributes = itinerary_attributes[itinerary.id.to_s]
      if attributes
        itinerary.attributes = attributes
      else
        itineraries.delete(itinerary)
      end
    end
  end
  
  def new_excursion_attributes=(excursion_attributes)
    excursion_attributes.each do |attributes|
      excursions.build(attributes)
    end
  end

  def existing_excursion_attributes=(excursion_attributes)
    excursions.reject(&:new_record?).each do |excursion|
      attributes = excursion_attributes[excursion.id.to_s]
      if attributes
        excursion.attributes = attributes
      else
        excursions.delete(excursion)
      end
    end
  end
  
  def new_payment_attributes=(payment_attributes)
    payment_attributes.each do |attributes|
      payments.build(attributes)
    end
  end

  def existing_payment_attributes=(payment_attributes)
    payments.reject(&:new_record?).each do |payment|
      attributes = payment_attributes[payment.id.to_s]
      if attributes
        payment.attributes = attributes
      else
        payments.delete(payment)
      end
    end
  end
  
  def new_comment_attributes=(comment_attributes)
    comment_attributes.each do |attributes|
      comments.build(attributes)
    end
  end

  def existing_comment_attributes=(comment_attributes)
    comments.reject(&:new_record?).each do |comment|
      attributes = comment_attributes[comment.id.to_s]
      if attributes
        comment.attributes = attributes
      else
        comments.delete(comment)
      end
    end
  end
  
  private
  
  def save_itineraries
    itineraries.each do |itinerary|
      itinerary.save(false)
    end
  end
  
  def save_excursions
    excursions.each do |excursion|
      excursion.save(false)
    end
  end
  
  def save_payments
    payments.each do |payment|
      payment.save(false)
    end
  end
  
  def save_comments
    comments.each do |comment|
      comment.save(false)
    end
  end
  
end

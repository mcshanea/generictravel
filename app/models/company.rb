class Company < ActiveRecord::Base
  has_many :bookings
  has_many :agents
  has_many :clients
  has_many :itineraries, :through => :bookings
  has_many :excursions, :through => :bookings
  has_many :services #, :through => :bookings, :source => :excursions
  has_many :payments, :through => :bookings
end

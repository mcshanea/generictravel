class Search < ActiveRecord::Base
  def bookings
    @bookings ||= find_bookings
  end
  
  def find_bookings
    Booking.find(:all, :conditions => conditions)
  end
  
  def departing
    ["bookings.departing >= ?", departing] unless departing.blank?
  end
  
  def arriving
    ["bookings.arriving >= ?", arriving] unless arriving.blank?
  end
  
  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end
  
  def conditions_clauses
    conditions_parts.map {|condition| condition.first}
  end
  
  def conditions_options
    conditions_parts.map {|condition| condition[1..-1]}.flatten
  end
  
  def conditions_parts
    methods.grep(/_conditions$/).map {|m| send(m)}.compact
  end
  
end

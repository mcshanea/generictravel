class Itinerary < ActiveRecord::Base
  belongs_to :booking
  
  attr_accessor :should_destroy
  
  ITIN_TYPE = YAML::load(File.open("#{RAILS_ROOT}/config/itinerary_types.yml"))
  
  formatted_time_accessor :departure_date, :arrival_date
  
  def should_destroy?
    should_destroy.to_i == 1
  end
  
#  def before_create
#    g = GData.new
#    g.login('alanaka.calendar@googlemail.com', 'bookingwp1')

#    save_itineraries_calendar(g)
#  end
  
  def save_itineraries_calendar(g)
    agent = Agent.find(self.booking.agent_id)
    
    event = {:title=>'title', 
              :content=>'content', 
              :author=>'pub.cog', 
              :email=>'pub.cog@gmail.com', 
              :where=>'Toulouse,France', 
              :startTime=>'2008-09-20T15:00:00.000Z', 
              :endTime=>'2008-09-20T17:00:00.000Z'}
    
    #event = { :title=>'Itinerary: '+Client.find(self.booking.leader_id).last_name,
    #:content=>'content',
    #:author=>agent.last_name,
    #:email=>agent.email,
    #:where=>self.departing + ' ' + self.arriving,
    #:startTime=>self.departure_date,
    #:endTime=>self.arrival_date}
    #response = g.new_event(event)
    
    #puts response
  end
end

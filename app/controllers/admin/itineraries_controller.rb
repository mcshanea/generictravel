class Admin::ItinerariesController < Admin::ScaffoldController
  layout "scaffold"

  before_filter :admin_login_required
  
  active_scaffold
 
  active_scaffold :itinerary do |config|
    config.columns = [ :itinerary_type, :departing, :departure_date, :arriving, :arrival_date, :booking_reference, :operator ]
  end
end

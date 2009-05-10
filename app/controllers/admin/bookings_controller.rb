class Admin::BookingsController < Admin::ScaffoldController
  layout "scaffold"
  
  before_filter :admin_login_required
  
  active_scaffold
 
  active_scaffold :booking do |config|
    config.columns = [:clients, :departing, :arriving, :itineraries, :excursions, :agent, :status ]
  end
end

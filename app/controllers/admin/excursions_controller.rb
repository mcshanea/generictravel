class Admin::ExcursionsController < Admin::ScaffoldController
  layout "scaffold"

  before_filter :admin_login_required
  
  active_scaffold
 
  active_scaffold :excursion do |config|
    #config.columns = [:clients, :departing, :arriving, :itineraries, :excursion, :status, :agent ]
  end
end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ScaffoldController < ActionController::Base
  #before_filter :authenticate, :except => [ :index ]
  
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8883d04d39ba0bfd789d070c5ef1aeea'
  
  #protected

  #def authenticate
  #  authenticate_or_request_with_http_basic do |username, password|
  #  username == "admin" && password == "adminadmin"
  #end
#end

end

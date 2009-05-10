class Admin::AgentsController < Admin::ScaffoldController
  layout "scaffold"
  
  before_filter :admin_login_required
  
  active_scaffold
 
  active_scaffold :agent do |config|
    config.columns = [ :login, :role, :active ]
  end
end

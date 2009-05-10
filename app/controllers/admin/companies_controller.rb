class Admin::CompaniesController < Admin::ScaffoldController
  layout "scaffold"
  
  before_filter :admin_login_required
  
  active_scaffold
 
  active_scaffold :company do |config|
    config.columns = [ :name, :licences, :active ]
  end
end

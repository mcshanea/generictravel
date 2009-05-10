ActionController::Routing::Routes.draw do |map|
  map.resources :rooms

  map.resources :rooms

  map.resources :rooms

  map.resources :hotels

  map.resources :companies

  map.resources :searches

  map.resources :searches

  map.resources :searches

  map.home '', :controller => 'home', :action => 'index'
  
  map.resources :agents
  
  map.resource :session
  
  map.resources :locations

  map.resources :itineraries

  map.resources :services

  map.resources :payments

  map.resources :excursions

  map.resources :clients

  map.resources :bookings
  
  map.signup '/signup', :controller => 'agents', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.password_reminder '/reminder', :controller => 'sessions', :action => 'edit'
  
  map.namespace :admin do |admin|
    admin.resources :agents, :active_scaffold => true

    admin.resources :services, :active_scaffold => true

    admin.resources :excursions, :active_scaffold => true

    admin.resources :payments, :active_scaffold => true

    admin.resources :clients, :active_scaffold => true
    
    admin.resources :companies, :active_scaffold => true

    admin.resources :intineraries, :active_scaffold => true

    admin.resources :bookings, :active_scaffold => true
  end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action.:format'
  map.root :controller => "bookings"
end

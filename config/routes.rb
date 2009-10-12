ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resource :user_session
  map.resources :advertisers
  map.resources :banners
  
  map.root :controller => 'user_sessions', :action => 'new'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

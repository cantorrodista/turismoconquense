ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resource :user_session
  map.resources :advertisers, :collection => { :delete => :delete }
  map.resources :banners
  map.resources :news, :collection => { :delete => :delete }
  map.root :controller => 'home', :action => 'index'


end


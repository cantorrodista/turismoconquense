ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resource :user_session
  map.resources :advertisers, :collection => { :delete => :delete }
  map.resources :banners, :collection => { :delete => :delete }
  map.resources :highlights, :path_prefix => "cuenca",:collection => { :delete => :delete } ,:member => {:attach => :get, :detach => :get}
  map.resources :categories, :collection => { :delete => :delete } do |categories|
    categories.resources :tags,  :controller => :navigation
  end
  map.highlights_categories 'cuenca/highlights/categories/:category' ,:controller => 'highlights', :action => 'index'
  
  map.root :controller => 'home', :action => 'index'
  map.resources :comments
  #Votaciones
  map.resources :ratings, :only => :create
  
  map.connect "resultados", :controller => :home, :action => :search
  map.connect "admin", :controller => :user_sessions, :action => :new

end

ActionController::Routing::Translator.translate_from_file('config','i18n-routes.yml')

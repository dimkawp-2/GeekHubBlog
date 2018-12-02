Rails.application.routes.draw do
  root 'index#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'index#index'

  # Users
  resources :users
  
  # Posts
  resources :posts

  # Sessions events
  get '/login', to: 'session#new'
  get '/logout', to: 'session#destroy'
  post '/login', to: 'session#create'

end

Rails.application.routes.draw do
  root 'index#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'index#index'

  # Users
  resources :users
  get '/profile', to: 'users#profile'
  
  # Posts
  resources :posts

  # Message
  # resources :comments
  post '/comments/:post_id', to: 'posts#create_comments'

  # Sessions events
  get '/login', to: 'session#new'
  get '/logout', to: 'session#destroy'
  post '/login', to: 'session#create'

end

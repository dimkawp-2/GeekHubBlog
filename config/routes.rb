Rails.application.routes.draw do
  root 'index#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Users
  resources :users
  get '/profile', to: 'users#profile'
  get '/admin', to: 'users#admin'
  # post '/edit/:id', to: 'users#update'
  
  # Posts
  resources :posts
  post '/posts/:id/youtube_created', to: 'posts#youtube_created'

  # Tags
  post '/posts/:id/tag_new', to: 'posts#create_new_tag'
  post '/posts/:id/edit_tags', to: 'posts#edit_tags'

  # Message
  # resources :comments
  post '/comments/:post_id', to: 'posts#create_comments'

  # Sessions events
  get '/logout', to: 'session#log_out'
  post '/login', to: 'session#create'

end

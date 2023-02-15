Rails.application.routes.draw do
  get 'oauth/new'
  get 'oauth/callback'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'photos/index'
  get 'photos/new'
  post 'photos/upload_to_app'
  post 'photos/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'photos#index'
end

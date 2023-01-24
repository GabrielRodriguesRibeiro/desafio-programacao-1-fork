Rails.application.routes.draw do
  # mount_devise_token_auth_for 'User', at: 'auth'
  root 'items#index'
  devise_for :users
  resources :items
  
  get '/items/filter', to: 'items#filter_item'  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
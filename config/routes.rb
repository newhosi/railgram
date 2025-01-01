# request URL /path will be mapped to the Path action in the Static Pages controller
Rails.application.routes.draw do
  # static
  root "static_pages#home" # "/" is the root path
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  # users
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users

  ## sessions
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end

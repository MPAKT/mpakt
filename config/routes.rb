Rails.application.routes.draw do
  root "welcome#index"

  resources :privileges, only: [:create, :index]
  resources :categories, only: [:create]
end

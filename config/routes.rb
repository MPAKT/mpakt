Rails.application.routes.draw do
  root "welcome#index"

  resources :privileges, only: [:create, :index]
  resources :categories, only: [:create]

  get "/ts_and_cs", to: 'policies#ts_and_cs'
  get "/privacy", to: 'policies#privacy'
  get "/cookies", to: 'policies#cookies'
end

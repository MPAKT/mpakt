Rails.application.routes.draw do
  devise_for :users
  root "welcome#index"

  resources :privileges, only: [:create, :index]
  resources :categories, only: [:create]

  authenticated :user do
    resources :users, only: [:index]
  end

  get "/ts_and_cs", to: 'policies#ts_and_cs'
  get "/privacy", to: 'policies#privacy'
  get "/cookies", to: 'policies#cookies'
  get "/goals", to: 'policies#goals'

  mount Thredded::Engine => '/forum'
end

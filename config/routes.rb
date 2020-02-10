Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'users'
    }

  root "welcome#index"

  resources :privileges, only: [:create, :index]
  resources :categories, only: [:create]
  resources :dashboard, only: [:show]

  devise_scope :user do
    resources :users, only: [:index, :show, :update]
    resources :blogs
    get "/salaries", to: 'privileges#salaries'
  end

  get "/ts_and_cs", to: 'policies#ts_and_cs'
  get "/privacy", to: 'policies#privacy'
  get "/cookies", to: 'policies#cookies'
  get "/goals", to: 'policies#goals'
  get "/blog", to: 'blogs#index'
  get "/dashboard", to: 'dashboard#show'

  mount Thredded::Engine => '/forum'
end

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    get 'reset_password', to: 'devise/passwords#new'
  end

  get 'logout', to: 'sessions#destroy'

  resources :profiles
  resources :lists
  resources :items
end

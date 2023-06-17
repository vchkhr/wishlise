Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#welcome"

  get "favicon/webmanifest", to: "home#webmanifest", format: :json
  get "favicon/browserconfig", to: "home#browserconfig", format: :xml

  devise_for :users

  resources :profiles, only: %i[ edit update ]
  get "complete_registration", to: "profiles#edit", as: "complete_registration"

  resources :wishlists do
    resources :items
  end
end

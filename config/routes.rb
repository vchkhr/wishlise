Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#welcome"

  get "favicon/webmanifest", to: "home#webmanifest", format: :json
  get "favicon/browserconfig", to: "home#browserconfig", format: :xml

  devise_for :users

  resources :profiles, only: %i[ edit update ]
  get "complete_registration", to: "profiles#complete_registration", as: "complete_registration"

  patch "profile/avatar", to: "profiles#update_avatar", as: "profile_avatar"
  delete "profile/avatar", to: "profiles#destroy_avatar"

  resources :wishlists

  resources :items, except: %i[ index ]
  patch "items/:id/image", to: "items#update_image", as: "item_image"
  delete "items/:id/image", to: "items#destroy_image"
end

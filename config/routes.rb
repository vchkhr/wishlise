Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#new"

  get "favicon/webmanifest" => "home#webmanifest", format: :json
  get "favicon/browserconfig" => "home#browserconfig", format: :xml

  devise_for :users

  resources :wishlists do
    resources :items
  end
end

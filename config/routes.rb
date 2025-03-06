Rails.application.routes.draw do
  get 'landing/home'
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  resources :users, :only => [:show]
  root to: "landing#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :favorites, only: [:create, :destroy]
  resources :sandwiches, only: [:index, :new, :create, :show] do
    member do
      post 'toggle_favorite', to: "sandwiches#toggle_favorite"
    end

    resources :reviews, only: [:index, :create, :destroy]
  end
end

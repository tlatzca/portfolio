Rails.application.routes.draw do
  get "searches/index"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :novels, only: [:index]
  resources :tracks, only: [:index]

  root "searches#index"
end

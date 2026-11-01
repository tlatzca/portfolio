Rails.application.routes.draw do
  get "searches/index"
  get "up" => "rails/health#show", as: :rails_health_check
  get "terms", to: "static#terms"
  get "privacy", to: "static#privacy"

  resources :books, only: [ :index ]
  resources :tracks, only: [ :index ]

  root "searches#index"
end

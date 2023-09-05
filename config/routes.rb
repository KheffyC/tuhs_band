Rails.application.routes.draw do
  devise_for :directors

  get 'home/index'
  root "home#index"

  namespace :admin do
    resources :programs
    resources :schools
    resources :districts

    root to: "schools#index"
  end

  resources :programs
end

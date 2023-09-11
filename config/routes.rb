Rails.application.routes.draw do
  devise_for :directors

  #  Home Page Route
  get 'home/index'
  root "home#index"

  # About Page Route
  get 'home/about'

  # Admin Routes for ActiveAdmin
  namespace :admin do
    resources :programs
    resources :schools
    resources :districts
    resources :boosters

    root to: "schools#index"
  end


  # Program Routes for each program at each school
  resources :programs
end

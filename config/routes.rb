Rails.application.routes.draw do
  devise_for :directors, skip: [:registrations]

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
    resources :fundraisers
    resources :staff_members
    resources :galleries do
      post :upload_image, on: :member
    end

    root to: "schools#index"
  end

  # Program Routes for each program at each school
  resources :programs, only: [:index]

  # School routes for each school
  resources :schools

  resources :amazon_pdfs, path: 'pdfs' do
    get :student_forms, on: :collection
  end

  resources :galleries

  resources :staff_members, only: [:index]

  resources :boosters, only: [:index]

  resources :fundraisers
  resources :donations do
    get :payment_confirmation, on: :collection, path: '/payment_confirmation/:id'
  end

  # Booster routes for each booster
  # resources :boosters

  # Contact routes for each contact
  resources :contacts
end

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

  namespace :practice_hub do
    resources :programs do
      resources :sections do
        get :new_collection, on: :member
        post :create_collection, on: :member

        resources :collections, except: [:index, :create] do
          get :new_music, on: :member
          post :create_music, on: :member
          get :view_music, on: :member, path: '/view_music/:sheet_id'
        end
      end
    end


  end


  # Program Routes for each program at each school
  resources :programs

  # School routes for each school
  resources :schools

  resources :amazon_pdfs, path: 'pdfs' do
    get :student_forms, on: :collection
  end

  resources :fundraisers
  resources :donations do
    get :payment_confirmation, on: :collection, path: '/payment_confirmation/:id'
  end

  # Booster routes for each booster
  # resources :boosters

  # Contact routes for each contact
  resources :contacts
end

Rails.application.routes.draw do
  get "customers/my_page", to: "customers#my_page"
  get "items", to: "items#index"
  get "items/:id", to: "items#show"
  root "homes#top"
  get "about", to: "homes#about"

  resources :cart_items, only: [ :index, :update, :destroy, :create ] do
    delete :destroy_all, on: :collection
  end

  resources :items do
    collection do
      get "search"
    end
  end

  resources :customers, only: [ :edit, :update ] do
    collection do
      get "my_page"
      get "information"
      get "information/edit", action: :edit
      get "unsubscribe"
      patch "withdraw"
    end
  end

  resources :addresses, only: [ :index, :edit, :create, :update, :destroy ]

  resources :orders, only: [ :new, :create, :index, :show ] do
    post "confirm", on: :collection
    get "complete", on: :collection
  end

  devise_for :admins, path: "admin", controllers: {
    sessions: "admins/sessions"
  }
  devise_for :customers, path: "customers", controllers: {
    registrations: "customers/registrations",
    sessions: "customers/sessions"
  }

  namespace :admin do
    root "homes#top"
    resources :orders, only: [ :show, :update ]
    resources :customers, only: [ :index, :show, :edit, :update ]
    resources :items, only: [ :index, :show, :edit, :new, :create, :update ]
    resources :genres, only: [ :index, :create, :edit, :update ]
    resources :order_details, only: [ :update ]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

Rails.application.routes.draw do
  get "categories/index"
  get "categories/show"
  get "categories/create"
  get "categories/update"
  get "categories/destroy"
  get "comments/index"
  get "comments/show"
  get "comments/create"
  get "comments/destroy"
  get "posts/index"
  get "posts/show"
  get "posts/update"
  get "posts/destroy"
  get "posts/create"
  get "users/index"
  get "users/show"
  get "users/create"
  get "users/destroy"
  get "users/update"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"


  resources :users do
    resources :posts
    resources :follows
  end

  resources :posts do
    resources :comments do
      resources :likes
    end
    resources :likes
  end

  resources :comments do
    resources :likes
  end

  resources :likes

  resources :categories do
    resources :posts, only: [ :index ]
  end

  resources :follows
end

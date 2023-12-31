require "sidekiq/web"
require "sidekiq/throttled/web"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "gift_issue_permissions#index"

  resource :dashboard, only: [:show]
  resources :gift_issue_permissions, only: [:new, :index] do
    collection { post :import }
    collection { post :issue }
  end

  # Replace Sidekiq Queues with enhanced version!
  Sidekiq::Throttled::Web.enhance_queues_tab!

  mount Sidekiq::Web => "/sidekiq"
end

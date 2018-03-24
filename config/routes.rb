Rails.application.routes.draw do

  
  resources :app_settings
  resources :entertainments


  resources :worlds do 
    resources :comments
  end

    resources :comments do
      member do
        put "upvote", to: "comments#upvote"
      put "downvote", to: "comments#downvote" 
    end
  end

  resources :tecs
  resources :googles
  devise_for :users
  root to: "pages#index"
  resource :subscription
  resources :subscriptions, only: [:new, :create, :destroy]


  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
end



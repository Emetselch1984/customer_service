Rails.application.routes.draw do
  config = Rails.application.config.system_service
  constraints host: config[:admin][:host] do
    namespace :admin do
      root 'top#index'
      get 'login', to: 'sessions#new'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
      resources :staff do
        resources :staff_events, only: %i[index]
      end
    end
  end
  constraints host: config[:staff][:host] do
    namespace :staff do
      root 'top#dashboard'
      get 'login', to: 'sessions#new'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
      resource :account do
        patch :confirm
      end
      resource :password, only: %i[show update edit]
      resources :customers
      resources :programs do
        resources :entries, only: [] do
          patch :update_all, on: :collection
        end
      end
    end
  end
  constraints host: config[:customer][:host] do
    namespace :customer do
      root 'top#index'
      get 'login', to: 'sessions#new'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
      resources :programs , only: %i[index show]
    end
  end
end

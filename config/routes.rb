Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: :index do
        resources :media, only: [:update], to: 'users/media#update'
      end
      resources :media, only: [:show, :index, :update]
      resources :trending_media, only: :index
    end
  end
end

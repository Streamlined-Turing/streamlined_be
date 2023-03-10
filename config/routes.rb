Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: :index do
        resources :media, only: [:create, :update, :destroy], controller: 'users/media'
        resources :lists, only: :index, controller: 'users/lists'
      end
      resources :media, only: [:show, :index]
      resources :trending_media, only: :index
    end
  end
end

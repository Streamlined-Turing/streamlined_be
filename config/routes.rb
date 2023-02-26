Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: :index
      resources :media, only: :show
      resources :trending_media, only: :index
    end
  end
end

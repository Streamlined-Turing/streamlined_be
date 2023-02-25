Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: :index
      resources :media, only: [:show, :index]
    end
  end
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: :index
      resources :media_details, only: :show
    end
  end
end

Rails.application.routes.draw do
  root "movies#index"

  devise_for :users

  resources :movies, only: [:index, :show]

  namespace :admin do
    resources :movies, except: [:index, :show] do
      resources :categories, only: [] do
        member do
          post :add_category
          delete :remove_category
        end
      end
    end
  end

  namespace :api do
    resources :ratings, only: [] do
      collection do
        put :update_or_create
        delete :destroy
      end
    end
  end
end

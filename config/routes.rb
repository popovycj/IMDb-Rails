Rails.application.routes.draw do
  root "movies#index"

  devise_for :users

  resources :movies, only: [:index, :show]

  namespace :admin do
    resources :movies, except: [:index, :show]
    resources :categories, only: [:create, :edit]
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

Rails.application.routes.draw do
  namespace :api do
    resources :images, only: :update
  end

  resources :folders do
    resources :bookmarks
  end

  resources :notes

  root "images#index"
end

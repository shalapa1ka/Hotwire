# frozen_string_literal: true

Rails.application.routes.draw do
  get  'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get  'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  resources :sessions, only: %i[index show destroy]
  resource  :password, only: %i[edit update]
  namespace :identity do
    resource :email,              only: %i[edit update]
    resource :email_verification, only: %i[show create]
    resource :password_reset,     only: %i[new edit create update]
  end

  namespace :api do
    resources :images, only: :update
  end

  resources :images, only: :index

  resources :folders do
    resources :bookmarks
  end

  resources :notes do
    collection do
      patch :reorder
    end
  end

  resources :rooms, only: %i[index show]

  resources :messages, only: %i[create edit update] do
    resource :likes, only: %i[create destroy]
  end

  root 'home#index'
end

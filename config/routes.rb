# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: [:index] do
        collection do
          post :login
        end
      end
      resources :users, param: :_username
      post '/auth/login', to: 'authentication#login'
      post '/auth/signup', to: 'authentication#signup'
      resources :verticals
      resources :categories
      resources :courses
    end
  end
end

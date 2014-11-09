Rails.application.routes.draw do
  root 'top#index'

  namespace :admin do
    root 'top#index'
    resource :session, only: [ :new, :create, :destroy ]
  end

  namespace :user do
    root 'top#index'
    resources :articles, only: [ :index, :show ] do
      resources :comments
    end
  end
end

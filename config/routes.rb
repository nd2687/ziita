Rails.application.routes.draw do
  root 'top#index'

  namespace :admin do
    root 'top#index'
    resource :session, only: [ :new, :create, :destroy ]
  end
end

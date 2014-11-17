Rails.application.routes.draw do
  root 'top#index'
  resource :session, only: [ :new, :create, :destroy ]
  resources :articles do
    resources :comments
  end

  namespace :admin do
    root 'top#index'
    resource :session, only: [ :new, :create, :destroy ]
  end

  scope "/:identify_name" do
    namespace :user, path: "" do
      root 'top#index'
      resource :session, only: [ :destroy ]
      resources :articles, only: [ :index, :show ] do
        resources :comments
      end
      resources :accounts
    end
  end

  get '*anything' => 'errors#routing_error'
end

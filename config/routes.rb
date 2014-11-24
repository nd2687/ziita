Rails.application.routes.draw do
  root 'top#index'

  resource :session, only: [ :new, :create, :destroy ]
  resources :articles, only: [ :index, :show ] do
    collection do
      get 'tag/:tag', to: 'articles#index', as: :tag
    end
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
      resources :articles do
        collection do
          get 'tag/:tag', to: 'articles#index', as: :tag
        end
        resources :comments
      end
      resources :accounts, except: [ :destroy ] do
        member do
          get :settings
          get :edit_password
          patch :update_password
        end
      end
    end
  end

  get '*anything' => 'errors#routing_error'
end

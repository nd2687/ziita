Rails.application.routes.draw do
  root 'top#index'

  resource :session, only: [ :new, :create, :destroy ]
  resource :account, only: [ :new, :create ]
  resource :account_identity, only: [ :new, :create ]
  get '/auth/:provider/callback', to: "sessions#callback"
  get '/auth/failure', to: "sessions#failure"

  resources :articles, only: [ :index, :show ] do
    member { patch "like", "unlike" }
    collection do
      get 'tag/:tag', to: 'articles#index', as: :tag
    end
    resources :comments, except: :index
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
        member { patch "like", "unlike" }
        collection do
          get 'tag/:tag', to: 'articles#index', as: :tag
          get :stacked
        end
        resources :comments, except: :index
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

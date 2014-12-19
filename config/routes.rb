Rails.application.routes.draw do
  root 'top#index'

  resource :session, only: [ :new, :create, :destroy ]
  resource :account, only: [ :new, :create ]
  resource :account_identity, only: [ :new, :create ]
  get '/auth/:provider/callback', to: "sessions#callback"
  get '/auth/failure', to: "sessions#failure"

  namespace :help do
    get :markdown
  end

  namespace :about do
    get :ziita
  end

  get 'inquiry' => 'inquiry#index'
  post 'inquiry/confirm' => 'inquiry#confirm'
  post 'inquiry/thanks' => 'inquiry#thanks'

  resources :articles, param: :access_token, only: [ :index, :show ] do
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
      resources :articles, param: :access_token do
        member { patch "like", "unlike" }
        collection do
          get 'tag/:tag', to: 'articles#index', as: :tag
          get :stacked
        end
        resources :comments, except: :index
        post :create_temp, on: :member
      end
      resources :drafts, param: :access_token, only: [ :index, :show, :update, :destroy ]
      resources :accounts, param: :account_token, except: [ :show, :destroy ] do
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

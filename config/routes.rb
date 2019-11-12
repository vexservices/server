require 'sidekiq/web'

Rails.application.routes.draw do
  get "/404", to: 'errors#not_found'
  get "/422", to: 'errors#unprocessable_entity'
  get "/500", to: 'errors#server_error'

  namespace :api, defaults: { format: 'json' } do
    resources :sessions, only: [:create, :destroy] do
      collection {post :register}
    end
    resources :categories
    resources :devices, only: [:show, :create, :update]
    resources :schedules, only: [:index, :show, :create, :destroy]

    resources :devices, only: [] do
      resources :messages, only: [:index, :create] do
        collection { get 'unread' }
      end
    end

    resources :stores, only: [:show] do
      resources :messages, only: [:index, :create] do
        collection { get 'unread' }
      end
    end

    resources :messages, only: [:index, :show] do
      get 'stores', on: :collection
    end

    resources :products do
      resources :pictures, only: [:show, :create, :destroy]

      member do
        post 'publish'
        post 'unpublish'
        post 'publish_all'
        post 'unpublish_all'
      end
    end

    resources :publishes, only: [] do
      member do
        post 'feature'
      end
    end
  end

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'pages#index'

    devise_for :admins,  skip: [ :registrations ]
    devise_for :sellers, skip: [ :registrations ]
    devise_for :users, path: 'auth', controllers: { registrations: "registrations" }

    resources :terms, only: [:index]
    resources :contacts, only: [:create]
    resources :sellers, only: [:show]

    resources :corporates, only: [] do
      resources :branch_stores, only: [:new, :create]
    end

    scope module: :store do
      resources :categories
      resources :clients
      resources :devices

      resources :stores do
        get :trees, on: :collection
      end

      resources :users
      resources :schedules
      resources :departments
      resources :logos,    only: [:index, :update]

      resources :orders,   only: [:create, :new] do
        collection { put 'skip' }
      end

      resources :payment_notifications, only: [:create]

      resources :invoices, only: [:index, :show] do
        member do
          get 'payment'
          get 'finalization'
        end
      end

      resource :recurring, only: [:destroy]

      resources :messages, only: [:index]

      resources :devices, only: [] do
        resources :stores, only: [] do
          resources :messages, only: [:index, :create] do
            collection { get 'unread' }
          end
        end
      end

      resources :notifications, only: [:new, :create]

      resources :products do
        resources :prices, only: [:new, :create, :edit, :update]
        resources :pictures, only: [:create, :destroy]

        member do
          post 'publish'
          post 'unpublish'
          post 'publish_all'
          post 'unpublish_all'
        end
      end

      resources :publishes, only: [] do
        member do
          post 'feature'
        end
      end

      resource :accept_term, only: [:show, :update]
      resource :payment,     only: [:edit, :update]
      resource :image
      resource :profile, only: [:edit, :update]
      resource :account, only: [:edit, :update]
      resource :plan,    only: [:show, :update]
      resource :app,     only: [:edit, :update]

      namespace :report do
        resources :products, only: [:index]
      end
    end

    namespace :seller do
      root to: 'dashboards#index'

      resource :profile, only: [:edit, :update]
      resources :reports, only: [:index]

      resources :sellers do
        resources :sellers
        resources :apps, only: [:index]
      end
    end

    namespace :admin do
      root to: 'corporates#index'

      resource :account, only: [:edit, :update]

      resources :plans
      resources :paypals
      resources :contacts, only: [:index, :show, :destroy]
      resources :departments
      resources :franchises
      resources :banners,  except: [:show]
      resources :videos

      resources :admins do
        member { get 'login' }
      end

      resources :users, only: [:edit, :update, :destroy] do
        member { get 'login' }
      end

      resources :sellers do
        member { get 'login' }

        resources :sellers
        resources :apps, only: [:index]
      end

      resources :businesses do
        resources :images, only: [:create, :destroy]
      end

      resource :term, only: [:edit, :update]
      resource :profile, only: [:edit, :update]

      resources :stores, only: [] do
        resources :recurrings, only: [:index, :show]
        resources :jobs, except: [:update, :edit]
        resources :reports do
          get :download, on: :collection
        end
      end

      resources :corporates do
        resources :stores, only: [:index, :show, :edit, :update, :destroy]
        resources :search, only: [:index]
        resource  :image, only: [:edit, :update]

        resource :app do
          get :download
        end

        resource :image, only: [] do
          get :download
        end
      end
      resources :jobs, only: [] do
        get :download, on: :collection
        get :retry,    on: :member
      end

      namespace :sandbox do
        resources :apps, except: [:show]
        resource :ios_push,     only: [:new, :create]
        resource :android_push, only: [:new, :create]
      end

      namespace :report do
        resources :apps,      only: [:index]
        resources :changes,   only: [:index,:update]
        resources :publishes, only: [:index]
        resources :images,    only: [:index]
      end

      mount Sidekiq::Web, at: '/sidekiq'
    end

    get '/:id' => 'redirects#index', constraints: { id: /[a-zA-Z|[0-9]]{6}/i}
  end

  get '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
  get '',      to: redirect("/#{I18n.default_locale}")
end

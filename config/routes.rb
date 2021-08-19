Rails.application.routes.draw do
  
  #namespace内ではエラーが出たため外に記述
  devise_for :customers, skip: 'registrations', controllers: {
      sessions:      'customers/sessions',
      passwords:     'customers/passwords',
      registrations: 'customers/registrations',
    }
  #editのURLが重複するのを避けるため、registrationsだけ個別に設定
  devise_scope :customer do
      get '/customers/sign_up' => 'customers/registrations#new',    as: :new_customer_registration
      post '/customers'        => 'customers/registrations#create', as: :customer_registration
  end

  devise_for :admin, path: "/admin", controllers: {
      sessions:      'admins/sessions',
      passwords:     'admins/passwords',
      registrations: 'admins/registrations'
    }

  namespace :admin do
    root to:'homes#top'
    resources :customers,      only: [:index, :show, :edit, :update]
    resources :products,       except: [:destroy]
    resources :genres,         only: [:index, :edit, :create, :update]
    resources :order_infos,    only: [:index, :show, :update] do
      resources :order_products, only: [:update]
    end
  end

  namespace :public, path:"" do
    #homes
    root to:'homes#top'
    get '/about' => 'homes#about'

    #customers
    get '/customers'             => 'customers#show'
    get '/customers/edit'        => 'customers#edit'
    patch '/customers'           => 'customers#update'
    get '/customers/suspend'     => 'customers#suspend'
    patch '/customers/suspended' => 'customers#suspended'

    resources :addresses,     except:[:show, :new]
    resources :products,      only:[:index, :show]
    resources :cart_products, only:[:index, :create, :update, :destroy]

    #cart_producst
    get '/cart_products/delete_all' => 'cart_products#delete_all'
    resources :order_infos,  only:[:index, :show, :new, :create]

    #order_infos
    get '/order_infos/confirm'         => 'order_infos#confirm'
    get '/order_infos/complete'        => 'order_infos#complete'
  end

end

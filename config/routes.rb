Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  namespace :admin do
    root to:'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :products, except: [:destroy]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :order_infos, only: [:index, :show, :update]
    resources :order_products, only: [:update]
  end
  
  
  namespace :public, path:"" do
    #homesコントローラー
    root to:'homes#top'
    get '/about' => 'homes#about'
    #customersコントローラー
    get '/customers' => 'customers#show'
    get '/customers/edit' => 'customers#edit'
    patch '/customers' => 'customers#update'
    get '/customers/suspend' => 'customers#suspend'
    patch '/customers/suspended' => 'customers#suspended'
    
    resources :addresses, except:[:show, :new]
    resources :products, only:[:index, :show]
    resources :cart_products, only:[:index, :create, :update, :destroy]
    delete '/cart_products/delete_all' => 'cart_products#delete_all'
    resources :oreder_infos, only:[:index, :show, :new, :create]
    get '/order_infos/confirm' => 'order_infos#confirm'
    get '/order_infos/complete' => 'oreder_infos#complete'
  end
  
end


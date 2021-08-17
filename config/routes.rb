Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
end


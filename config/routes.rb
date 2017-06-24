Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  root 'home#index'
  get 'users/my_profile'  => 'users#my_profile'

  namespace :admin do
    resources :users
    resources :categories
    resources :dashboards
  end

  get 'product/create_product' => 'products#create'
  resources :products do
    member do
      put 'favorite'
    end
  end

end

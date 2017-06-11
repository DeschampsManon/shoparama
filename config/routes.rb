Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'users/my_profile'  => 'users#my_profile'

  namespace :admin do
    resources :users
  end

  get 'product/create_product' => 'products#create'
  resources :products

end

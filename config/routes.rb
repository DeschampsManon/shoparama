Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
  root 'home#index'
  get 'users/my_profile'  => 'users#my_profile'

  namespace :admin do
    resources :users
    resources :categories
    resources :dashboards do
      collection do
        post 'change_block_chart'
        post 'remove_chart_from_dashboard'
      end
    end
    resources :block_charts
  end

  get 'product/create_product' => 'products#create'
  resources :products do
    member do
      put 'favorite'
    end
  end

end

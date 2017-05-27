Rails.application.routes.draw do
  devise_for :users

  root 'home#index'
  get 'users/my_profile'  => 'users#my_profile'
end

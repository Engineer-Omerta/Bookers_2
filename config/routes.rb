Rails.application.routes.draw do
  root 'top#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/about' => 'top#show'
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  resources :users, only: [:index, :edit, :update, :show]
end


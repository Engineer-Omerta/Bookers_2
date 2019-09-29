Rails.application.routes.draw do
  root 'top#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/about' => 'top#show'
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
  #doはbooksに紐付く親子関係になるという意味。これを「ネストする」という。他のURLを生成してもいいが、ネストした方がURLが分かりやすい。
  	resources :post_comments, only:[:create, :destroy, :edit, :update]
  	resources :favorites, only:[:create, :show]
  	resource :favorites, only:[:destroy]
  	   #resource :favorites, only:[:create, :destroy, :show] resourceと単数にする事でfavoritesのidがルーティングされなくなる
  end
  resources :users, only: [:index, :edit, :update, :show]

end


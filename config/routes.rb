Rails.application.routes.draw do

  devise_for :users

  root to: 'homes#top'
  get "home/about" => "homes#about"

  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resources :book_comments, only: [:create,:destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:new, :create, :edit, :update, :index, :show] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do

  devise_for :users

  root to: 'homes#top'
  get "home/about" => "homes#about"

  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  resources :users, only: [:new, :create, :edit, :update, :index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

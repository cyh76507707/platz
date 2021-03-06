Rails.application.routes.draw do
  
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  mount Ckeditor::Engine => '/ckeditor'
  root 'pages#home'
  get '/menu' => 'pages#menu'
  get '/beans' => 'pages#beans'
  get '/blog' => 'pages#blog'

  get '/login' => 'admin/sessions#new'
  get '/logout' => 'admin/sessions#destroy'
  get '/admin' => 'admin/posts#index'

  resources :posts

  namespace :admin do
    resources :posts
    resources :notifications, only: [:index, :destroy]
    resources :messages, only: [:index, :show, :update, :destroy]
    resources :visitors, only: [:index, :destroy]
    resources :comments, only: [:index, :update, :destroy]
    resources :tags, except: [:index]
    resources :sessions, only: [:new, :create, :destroy]
    resources :moderators, only: [:index, :edit, :update]
  end
end

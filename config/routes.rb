# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories
  authenticated :user, ->(user) { user.admin? } do
    get 'admin', to: 'admin#index'
    get 'admin/posts'
    get 'admin/comments'
    get 'admin/users'
    get 'admin/categories'
    get 'admin/post/:id', to: 'admin#show_post', as: 'admin_post'
    get 'admin/user/:id', to: 'admin#show_user', as: 'admin_user'
    get 'admin/destroy/:id' => 'admin#destroy', :via => :delete, :as => :admin_destroy_user

    # resources :posts, only: [:index, :show]
    post '/unapprove_post/:user_id/:id', to: 'posts#unapprove_post', as: :unapprove_post
    post '/approve_post/:user_id/:id', to: 'posts#approve_post', as: :approve_post

    # user_role_path(:user_id, :role)
    post '/user_role_admin/:user_id/:id', to: 'users#user_role_admin', as: :user_role_admin
    post '/user_role_user/:user_id/:id', to: 'users#user_role_user', as: :user_role_user
  end
  
  resources :posts do
    resources :likes
  end

  get 'search', to: 'search#index'
  get 'users/profile'
  get 'users/uneproved_posts'

  # devise_scope :user do
  #   post 'users/sign_up', to: 'devise/registrations#create'
  # end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/u/:id', to: 'users#profile', as: 'user'
  get '/uneproved_posts/:id', to: 'users#uneproved_posts', as: 'user_uneproved_posts'

  scope controller: :static do
    get :pricing
  end

  resources :billings, only: :create

  namespace :purchase do
    resources :checkouts
  end

  get 'success', to: 'purchase/checkouts#success'

  resources :subscriptions
  resources :webhooks, only: :create

  resources :posts do
    resources :comments
  end
  get 'about', to: 'pages#about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'posts#index'
end

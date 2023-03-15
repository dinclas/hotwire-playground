Rails.application.routes.draw do
  resources :posts
  resources :likes

  get 'home/index'
  devise_for :users

  post 'posts/:id/like', to: 'posts#like', as: :like_post
  post 'posts/:id/repost', to: 'posts#repost', as: :repost
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index"
end

Rails.application.routes.draw do
  get 'blog/index'

  resources :posts

  root 'blog#index'
end

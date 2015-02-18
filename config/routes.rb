Rails.application.routes.draw do
  get 'blog/index'

  root 'blog#index'
end

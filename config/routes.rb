Rails.application.routes.draw do
  get 'posts/index'
  devise_for :users
  root to: 'posts#index'
  namespace :admin do
    get 'terms', to: 'terms#set_term'
  end
end

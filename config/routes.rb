Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources 'posts', only: [:index, :create, :destroy]
  namespace :admin do
    get 'terms', to: 'terms#set_term'
  end
end

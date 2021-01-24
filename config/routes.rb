Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end
  root to: 'posts#index'
  resources 'posts', only: [:index, :create, :update, :destroy]
  namespace :admin do
    get 'terms', to: 'terms#set_term'
  end
end

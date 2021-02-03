Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end
  
  root to: 'users#index'
  resources 'users', only: :index do
    collection do
      get 'search'
      get '/:id/profile', to: 'users#get_profile'
      patch '/:id/profile', to: 'users#update_profile'
    end
  end
  
  resources 'posts', only: [:index, :create, :update, :destroy] do
    collection do
      get 'search'
    end
  end
  get '/posts/:id', to: 'posts#check_favorite'
  get '/favorites/:id', to: 'posts#get_favorites'
  
  resources 'exercises', only: [:index, :update] do
    member do
      get '/sentence', to: 'exercises#get_sentences'
      get '/word', to: 'exercises#get_words'
      get '/sentence/english', to: 'exercises#sentence_english_scores'
      get '/sentence/japanese', to: 'exercises#sentence_japanese_scores'
      get '/word/english', to: 'exercises#word_english_scores'
      get '/word/japanese', to: 'exercises#word_japanese_scores'
    end
  end

  namespace :admin do
    resources 'terms', only: [:index, :create, :update, :destroy]
  end
end

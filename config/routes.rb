Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end
  
  root to: 'posts#index'
  resources 'posts', only: [:index, :create, :update, :destroy] do
    collection do
      get '/user/:id', to: 'posts#get_profile'
      patch '/user/:id', to: 'posts#update_profile'
    end
  end
  
  resources 'exercises', only: [:index, :update] do
    member do
      get '/sentence', to: 'exercises#get_sentences'
      get '/sentence/english', to: 'exercises#sentence_english_scores'
      get '/sentence/japanese', to: 'exercises#sentence_japanese_scores'
      get '/word', to: 'exercises#get_words'
      get '/word/english', to: 'exercises#word_english_scores'
      get '/word/japanese', to: 'exercises#word_japanese_scores'
    end
  end

  namespace :admin do
    resources 'terms', only: [:index, :create]
  end
end

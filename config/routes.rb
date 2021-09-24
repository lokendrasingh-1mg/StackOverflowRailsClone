require 'sidekiq/web'

Rails.application.routes.draw do
  root 'questions#index'

  mount Sidekiq::Web => '/sidekiq' # mount Sidekiq::Web in your Rails app

  devise_for :users

  get ':commentable_type/comments/', to: 'comments#index'
  post ':commentable_type/:commentable_id/comments/', to: 'comments#create'
  get ':commentable_type/:commentable_id/comments/', to: 'comments#show'
  put ':commentable_type/:commentable_id/comments/:id', to: 'comments#update'
  delete ':commentable_type/:commentable_id/comments/:id', to: 'comments#destroy'

  post 'comments/:id/votes/', to: 'comment_vote#votes'

  resources :questions do
    post :votes, on: :member
    resources :answers, only: %i[create show update destroy] do
      post :votes, on: :member
    end
  end
end

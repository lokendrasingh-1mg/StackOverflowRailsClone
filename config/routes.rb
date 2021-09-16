Rails.application.routes.draw do
  root 'questions#index'

  devise_for :users

  get ':commentable_type/comments/', to: 'comments#index'
  post ':commentable_type/:commentable_id/comments/', to: 'comments#create'
  put ':commentable_type/:commentable_id/comments/:id', to: 'comments#update'
  delete ':commentable_type/:commentable_id/comments/:id', to: 'comments#destroy'

  resources :questions do
    resources :answers
  end
end

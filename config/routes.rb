Rails.application.routes.draw do
  root 'questions#index'

  devise_for :users

  get 'comments/:commentable_type/', to: 'comments#index'
  get 'comments/:commentable_type/:commentable_id/', to: 'comments#show'
  post 'comments/:commentable_type/:commentable_id/', to: 'comments#create'
  put 'comments/:commentable_type/:commentable_id/', to: 'comments#update'
  delete 'comments/:commentable_type/:commentable_id/', to: 'comments#destroy'

  resources :questions do
    resources :answers
  end
end

Rails.application.routes.draw do
  root 'questions#index'

  devise_for :users

  concern :commentable do
    resources :comments
  end

  resources :questions, concerns: :commentable do
    resources :answers, concerns: :commentable
  end
end

Rails.application.routes.draw do
  root 'questions#index'

  devise_for :users

  concern :votable do
    resources :votes
  end

  concern :commentable do
    resources :comments, concerns: :votable
  end

  resources :questions, concerns: %i[commentable votable] do
    resources :answers, concerns: %i[commentable votable]
  end
end

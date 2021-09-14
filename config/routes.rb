Rails.application.routes.draw do
  root 'question#index'

  devise_for :users
  resources :question
end

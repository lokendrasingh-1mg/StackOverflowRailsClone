Rails.application.routes.draw do
  root 'questions#index'

  devise_for :users
  resources :questions do
    # TODO: level of nesting for comments
    resources :answers
  end
end

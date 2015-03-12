Rails.application.routes.draw do
  root 'top#index'

  resource :session, only: [ :new, :create, :destroy ]
  resources :accounts
end

Rails.application.routes.draw do
  root 'top#index'

  resource :session, only: [ :new, :create, :destroy ]
  resources :accounts do
    post :follow, on: :member
    resources :tweets, only: [ :new, :create ] do
      post :favorite, on: :member
      delete :unfavorite, on: :member
    end
  end
end

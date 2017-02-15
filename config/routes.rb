Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :quotes, only: [:index, :create, :destroy]
end

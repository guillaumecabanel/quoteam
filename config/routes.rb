Rails.application.routes.draw do
  devise_for :users

  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'

    patch 'users/:id/enroll', to: 'profiles#enroll', as: 'enroll_user'

    resources :teams, only: [:show, :new, :create] do
      resources :quotes, only: [:index, :create, :destroy] do
        member do
          patch :upvote
        end
      end
    end
  end
end

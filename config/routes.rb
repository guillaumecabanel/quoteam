Rails.application.routes.draw do
  devise_for :users

  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'

    resources :teams, only: [:show, :new, :create] do
      resources :quotes, only: [:index, :create, :destroy] do
        member do
          patch :upvote
        end
      end
    end

    resources :enrollments, only: [:new, :create]
  end
end

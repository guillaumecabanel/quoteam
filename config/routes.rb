Rails.application.routes.draw do
  mount LetsencryptHttpChallenge::Engine => "/" unless ENV['LE_HTTP_CHALLENGE_RESPONSE'].blank?

  devise_for :users

  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'

    resources :teams, only: [:index, :show, :new, :create] do
      resources :quotes, only: [:create, :destroy] do
        member do
          patch :upvote
        end
      end
    end

    resources :enrollments, only: [:new, :create]
  end
end

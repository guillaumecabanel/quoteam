Rails.application.routes.draw do
  mount LetsencryptHttpChallenge::Engine => "/" unless ENV['LE_HTTP_CHALLENGE_RESPONSE'].blank?

  devise_for :users, controllers: { registrations: "users/registrations" }


  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'

    resources :teams, only: [:index, :show, :new, :create] do
      resources :quotes, only: [:index, :update, :create, :destroy] do
        member do
          patch :like
        end
      end
    end

    resource :profile, only: [:show, :edit, :update]
    resources :enrollments, only: [:new, :create]
    get 'admin', to: 'pages#admin'
  end
end

Rails.application.routes.draw do
  root to: redirect('scoreboard/show')
  get 'scoreboard/show'

  resources :matches, only: [:new, :create]

  namespace :api do
    resources :players, only: :index

    resource :ongoing_match, only: [:show, :destroy] do
      put "home_point"
      put "away_point"
      put "rewind"
      put "finalize"
    end

    get "stats/points"
  end
end

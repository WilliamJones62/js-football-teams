Rails.application.routes.draw do
  root 'static_pages#home'
  # destroy as get requests
  get '/teams/:id/destroy', to: 'teams#destroy'
  resources :player_games
  resources :teams do
    # nested resource for teams
    resources :players, only: [:show]
    resources :games, only: [:show]
  end
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/users/sign_out', to: 'static_pages#home'

end

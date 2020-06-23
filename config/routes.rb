Rails.application.routes.draw do
  root to: 'teams#index'
  get '/:slug', to: 'teams#show', as: :show_team
  resources :team_users, only: [:create]
  resources :teams, only: [:create, :destroy]
  resources :groups, only: [:create, :destroy]
  devise_for :users, controllers: { registrations: 'registrations' }
end

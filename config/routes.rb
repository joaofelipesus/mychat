Rails.application.routes.draw do
  root to: 'teams#index'
  resources :messages, only: [:create, :index]
  resources :team_users, only: [:create, :destroy, :update, :index]
  resources :teams, only: [:create, :destroy]
  resources :groups, only: [:create, :destroy]
  devise_for :users, controllers: { registrations: 'registrations' }
  get '/:slug', to: 'teams#show', as: :show_team
end

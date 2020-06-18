Rails.application.routes.draw do
  root to: 'teams#index'
  resources :teams, only: [:create]
  devise_for :users, controllers: { registrations: 'registrations' }
end

Rails.application.routes.draw do
  root to: 'teams#index'
  devise_for :users, controllers: { registrations: 'registrations' }
end

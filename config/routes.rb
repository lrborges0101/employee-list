Rails.application.routes.draw do
  root 'employees#index'

  resources :employees

  resources :events, only: [:index]
end

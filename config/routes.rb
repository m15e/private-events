Rails.application.routes.draw do
  resources :events
  resources :users
  resources :sessions, only: %i[new create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'events#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end

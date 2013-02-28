FactoryApp::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  match "/signin",  to: "sessions#new"
  match "/signout", to: "sessions#destroy", via: :delete

  namespace :backend do
    resources :users
    root to: 'dashboard#index'
  end
end
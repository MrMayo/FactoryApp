FactoryApp::Application.routes.draw do
  namespace :backend do
    resources :users
    
    resources :sessions, only: [:new, :create, :destroy]
    match "/signin",  to: "sessions#new"
    match "/signout", to: "sessions#destroy", via: :delete
    
    root to: 'dashboard#index'
  end
end
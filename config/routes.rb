FactoryApp::Application.routes.draw do
  namespace :backend do
    resources :users
    root to: 'dashboard#index'
  end
end
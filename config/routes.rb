Rails.application.routes.draw do
  resources :payments
  resources :orders
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete '/receipts/:id', to: 'receipts#complete'
  get '/receipts', to: 'receipts#index'
  get :token, controller: 'application'
end

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index, :create, :show, :update, :destroy]
    post '/login', to: 'users#login'
    resources :posts, only: [:create, :index, :destroy]
  end
  
end

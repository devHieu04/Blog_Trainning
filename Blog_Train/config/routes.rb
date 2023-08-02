Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index, :create, :show, :update, :destroy]
    post '/login', to: 'users#login'
    get '/current', to: 'users#current'
    resources :posts, only: [:create, :index, :destroy, :update, :show] do
      resources :comments, only: [:index, :create]
      get 'show_comments', on: :member # Đổi tên route thành 'show_comments'
    end
    resources :comments, only: [:create, :index, :destroy , :update]
  end
end

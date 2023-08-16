Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  root 'pages#index'
  get '/register', to: 'pages#register'
  get '/login', to: 'pages#login'
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index, :create, :show, :update, :destroy]
    post '/login', to: 'users#login'
    delete '/logout', to: 'users#logout'
    get '/current', to: 'users#current'
    resources :posts, only: [:create, :index, :destroy, :update, :show] do
      resources :comments, only: [:index, :create]
      get 'show_comments', on: :member # Đổi tên route thành 'show_comments'
      delete 'delete_all_comments', on: :member, to: 'comments#destroy_all' # Thêm route để xoá hết comment
    end
    resources :comments, only: [:create, :index, :destroy, :update]
  end
end

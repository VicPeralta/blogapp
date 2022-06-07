Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
  get '/users/:user_id/posts', to:'posts#index', as: 'user_posts'
  get '/users/:user_id/post/new', to: 'post#new', as: 'post_new'
  post '/users/:user_id/post/new', to: 'post#create'
  get '/users/:user_id/posts/:id', to:'posts#show', as: 'user_post'
  get '/users/', to:'users#index', as: 'users'
  get '/users/:id', to:'users#show', as: 'user'
  match '*unmatched', to: 'application#route_not_found', via: :all
end

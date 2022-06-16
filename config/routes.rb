Rails.application.routes.draw do
  get 'users/:author_id/show', to: 'api#show_users_posts', as: 'api_show_posts'
  get 'posts/:post_id/comments', to: 'api#show_posts_comments', as: 'api_show_comments'
  post 'posts/:post_id/comments', to: 'api#add_comment_to_post', as: 'api_add_comment'
  devise_for :users
  root 'users#index'
  get '/users/:user_id/posts', to:'posts#index', as: 'user_posts'
  get '/users/:user_id/post/new', to: 'post#new', as: 'post_new'
  post '/users/:user_id/post/new', to: 'post#create'
  get '/users/:user_id/posts/:id', to:'posts#show', as: 'user_post'
  delete '/users/:user_id/posts/:id', to:'posts#delete', as: 'post_delete'
  get '/users/', to:'users#index', as: 'users'
  get '/users/:id', to:'users#show', as: 'user'
  resources :service, path: 'service/like', to:'service#like'
  post 'service/comment', to:'service#comment', as: 'service_comment'
  delete 'service/comment/:user_id/posts/:post_id/:comment_id', to:'service#delete_comment', as: 'delete_comment'
  match '*unmatched', to: 'application#route_not_found', via: :all
end

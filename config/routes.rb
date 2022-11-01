Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users

  root 'users#index'
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
    end
  end
  get 'api/users/:author_id/show', to: 'api#show_users_posts', as: 'api_show_posts'
  post 'api/users/:author_id/show', to: 'api#show_users_posts'
  get 'api/posts/:post_id/comments', to: 'api#show_posts_comments', as: 'api_show_comments'
  post 'api/posts/:post_id/comments', to: 'api#add_comment_to_post', as: 'api_add_comment'
  match '*unmatched', to: 'application#route_not_found', via: :all
end

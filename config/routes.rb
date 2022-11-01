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

  match '*unmatched', to: 'application#route_not_found', via: :all
end

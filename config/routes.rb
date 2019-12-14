Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get 'users/validate', to: 'users#validate'
    get 'users/:id/timeline', to: 'users#timeline'
    post 'users/login', to: 'users#login'

    resources :books, only: [:create, :show, :update, :destroy]
    resources :comments, only: [:create, :show, :destroy]
    resources :follows, only: [:create, :show, :destroy]
    resources :likes, only: [:create, :show, :destroy]
    resources :progresses, only: [:create, :show, :update, :destroy]
    resources :reviews, only: [:create, :show, :update, :destroy]
    resources :shelf_books, only: [:create, :show, :update, :destroy]
    resources :shelves, only: [:create, :show, :update, :destroy]
    resources :users, only: [:create, :show, :update, :destroy]


  end
end
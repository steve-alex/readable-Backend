Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get 'users/validate', to: 'users#validate'
    get 'users/timeline', to: 'users#timeline'
    post 'users/login', to: 'users#login'
    get 'users/:id/profile', to: 'users#profile'

    post 'books/search', to: 'books#search'
    post 'books/find_or_create', to: 'books#find_or_create'

    post 'shelves/add_book', to: 'shelves#add_book'

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
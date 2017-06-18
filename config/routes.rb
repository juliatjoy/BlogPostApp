Rails.application.routes.draw do
  root 'blog_posts#index'
  devise_for :users
  # resources :users do
  #   member do
  #     get 'following'
  #   end
  # end
  get '/users/:id/following' => 'users#following', as: 'following'
  resources :blog_posts do
    resources :comments
    member do
      post 'like_or_unlike'
      get 'selected_user_profile'
      post 'follow'
      post 'unfollow'
    end
  end
  post '/signup' => 'users#signup'
  get '/my_blogs' => 'blog_posts#my_blogs'
  get '/home' => 'blog_posts#home'
  get '/profile' => 'users#profile'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

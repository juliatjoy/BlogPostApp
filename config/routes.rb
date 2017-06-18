Rails.application.routes.draw do
  root 'blog_posts#home'
  devise_for :users
  resources :blog_posts do
    resources :comments
  end
  post '/signup' => 'users#signup'
  get '/my_blogs' => 'blog_posts#my_blogs'
  get '/home' => 'blog_posts#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

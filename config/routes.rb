Rails.application.routes.draw do
  root 'blog_posts#index'
  devise_for :users
  resources :blog_posts do
    resources :comments
    member do
      get :home
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

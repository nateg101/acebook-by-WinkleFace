Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :auths, only: [:create]
      resources :posts
      resource :users, only: [:create]
    end
  end

  root 'home#index'
  get '/user_not_found', to: 'errors#user_not_found', as: 'user_not_found'
  # devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    # resources :likes
    resources :comments do
    end
  end
  post '/posts/:post_id/like', to: 'likes#upvote', as: 'like_post'
  post '/posts/:post_id/unlike', to: 'likes#downvote', as: 'unlike_post'
  post '/posts/:post_id/comment/:comment_id/like', to: 'likes#upvote', as: 'like_post_comment'
  post '/posts/:post_id/comment/:comment_id/unlike', to: 'likes#downvote', as: 'unlike_post_comment'

  # get '/:username' => 'posts#index', :as => 'vanity_url'
end

require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  before :each do
    @user = User.create(username: 'username', email: 'test@rspec.com', password: 'password')
    key = AuthenticateUserCommand.call(@user.email, @user.password).result
    @my_headers = { 
      "ACCEPT": "application/json",
      "Authorisation": key
    }
    @post = Post.create(message: 'hello', user_id: @user.id, wall_id: @user.id)
  end

  describe 'GET #index' do
    it 'returns 200' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'returns all posts in json format' do
      user = FactoryBot.create(:user)
      post = Post.create(message: "Hello world", user_id: user.id)
      comment = Comment.create(message: 'A comment', user_id: user.id, post_id: post.id)
      post.liked_by user
      comment.liked_by user
      get :index
      expect(response.body).to include('Hello world')
      expect(response.body).to include('A comment')
    end

    it 'can return all posts on a single wall' do
      user = FactoryBot.create(:user)
      post = Post.create(message: "Hello world", user_id: user.id, wall_id: user.id)
      get :index, params: {
        wall_id: user.id
      }
      expect(response.body).to include('Hello world')
      expect(response.body).to_not include('hello')
    end
  end

  describe 'POST #create' do
    it 'responds unauthorized' do
      post :create
      expect(response).to have_http_status(:unauthorized)
    end

    it 'responds 201' do
      request.headers.merge!(@my_headers)
      post :create, params: {
        post: {
          message: 'A Post',
          wall_id: @user.id
        }
      }

      expect(response).to have_http_status(201)
    end

    it 'creates a post' do
      request.headers.merge!(@my_headers)
      post :create, params: {
        post: {
          message: 'A Post',
          wall_id: @user.id
        }
      }
      expect(Post.find_by(message: 'A Post')).to be_a Post
    end
  end

  describe 'PATCH #update' do
    it 'responds 200' do
      request.headers.merge!(@my_headers)
      patch :update, params: {
        post: {
          message: 'A Post',
        },
        id: @post.id
      }

      expect(response).to have_http_status(200)
    end

    it 'updates a post' do
      request.headers.merge!(@my_headers)
      patch :update , params: {
        post: {
          message: 'A Post',
        },
        id: @post.id
      }

      expect(Post.find(@post.id).message).to eq "A Post"
    end

    it 'responds unauthorized when user isnt post owner' do
      user = FactoryBot.create(:user)
      key = AuthenticateUserCommand.call('person@person.com', 'password').result
      headers = { 
        "ACCEPT": "application/json",
        "Authorisation": key
      }
      request.headers.merge!(headers)
      patch :update, params: {
        post: {
          message: 'A Post'
        },
        id: @post.id 
      }
      expect(response).to have_http_status(:unauthorized)
      expect(Post.find(@post.id).message).to eq 'hello'
    end
  end

  describe 'DELETE #destroy' do
    it 'responds 200' do
      request.headers.merge!(@my_headers)
      delete :destroy, params: {
        id: @post.id
      }

      expect(response).to have_http_status(200)
    end

    it 'destroys a post' do
      request.headers.merge!(@my_headers)
      delete :destroy, params: {
        id: @post.id
      }

      expect(Post.find_by(message: 'hello')).to be nil
    end

    it 'responds unauthorized when user isnt post owner' do
      user = FactoryBot.create(:user)
      key = AuthenticateUserCommand.call('person@person.com', 'password').result
      headers = { 
        "ACCEPT": "application/json",
        "Authorisation": key
      }
      request.headers.merge!(headers)
      delete :destroy, params: {id: @post.id }
      expect(response).to have_http_status(:unauthorized)
      expect(Post.find(@post.id)).to eq @post
    end
  end
end

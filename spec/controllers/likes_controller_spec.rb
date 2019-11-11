require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  before :each do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe 'POST /posts/:post_id/' do
    it 'responds with 200' do
      post = Post.create(message: "Hello, world!", user_id: @user.id)
      post.vote_by voter: @user

      expect(response).to have_http_status(200)
    end

    it 'responds with 200' do
      post = Post.create(message: "Hello, world!", user_id: @user.id)
      post.vote_by voter: @user
      post.unliked_by @user

      expect(response).to have_http_status(200)
    end
  end

  describe 'Post /posts/:post_id/comment/:comment_id/' do
    it 'responds with 200' do
      post = Post.create(message: "Hello, world!", user_id: @user.id)
      comment = Comment.create(message: "Comment", user_id: @user.id, post_id: post.id)
      comment.vote_by voter: @user

      expect(response).to have_http_status(200)
    end

    it 'responds with 200' do
      post = Post.create(message: "Hello, world!", user_id: @user.id)
      comment = Comment.create(message: "Comment", user_id: @user.id, post_id: post.id)
      comment.vote_by voter: @user
      comment.unliked_by @user

      expect(response).to have_http_status(200)
    end
  end
end

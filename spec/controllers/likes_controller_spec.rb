require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  before :each do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe 'POST /posts/:post_id/' do
    it 'likes a post' do
      post = Post.create(message: "Hello, world!", user_id: @user.id)
      like = post.vote_by voter: @user

      expect(@user.voted_on?(post)).to be true
      expect(@user.voted_for?(post)).to be true
      expect(@user.find_up_voted_items.size).to eq(1)
    end

    it 'unlikes a post' do
      post = Post.create(message: "Hello, world!", user_id: @user.id)
      like = post.vote_by voter: @user
      unlike = post.unliked_by @user

      expect(@user.find_up_voted_items.size).to eq(0)
    end
  end

  describe 'Post /posts/:post_id/comment/:comment_id/' do
    it 'likes a comment' do
      post = Post.create(message: "Hello, world!", user_id: @user.id)
      comment = Comment.create(message: "Comment", user_id: @user.id, post_id: post.id)
      like = comment.vote_by voter: @user

      expect(@user.voted_on?(comment)).to be true
      expect(@user.voted_for?(comment)).to be true
      expect(@user.find_up_voted_items.size).to eq(1)
    end

    it 'unlikes a comment' do
      post = Post.create(message: "Hello, world!", user_id: @user.id)
      comment = Comment.create(message: "Comment", user_id: @user.id, post_id: post.id)
      like = comment.vote_by voter: @user
      unlike = comment.unliked_by @user

      expect(@user.find_up_voted_items.size).to eq(0)
    end
  end
end

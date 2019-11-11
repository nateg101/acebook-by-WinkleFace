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
    end

    it 'unlikes a post' do
      post = Post.create(message: "Hello, world!", user_id: @user.id)
      like = post.vote_by voter: @user
       # post.votes_for.down.by_type(@user)
      post.unliked_by @user

      # expect(post.vote_flag).to be false
      expect(@user.find_up_voted_items.size).to eq(0)
    end
  end
end

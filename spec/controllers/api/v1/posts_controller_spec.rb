require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe 'GET /api/v1/posts' do
    it 'returns 200' do
      get :show
      puts "Request:"
      puts request.url
      puts response.headers
      puts response.redirect_url
      expect(response).to have_http_status(200)
    end

    it 'returns all posts in json format' do
      user = FactoryBot.create(:user)
      post = Post.create(message: "Hello world", user_id: user.id)
      get :show
      expect(response.body).to eq(Post.all.to_json)
    end
  end

end

require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe 'GET #show' do
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

  describe 'POST #create' do
    before :each do
      @user = User.create!(username: 'username', email: 'test@rspec.com', password: 'password')
      @key = AuthenticateUserCommand.call('test@rspec.com', 'password').result
      @my_headers = { 
        "ACCEPT": "application/json",
        "Authorisation": @key
      }
    end
    it 'responds unauthorized' do
      post :create
      expect(response).to have_http_status(:unauthorized)
    end

    it 'responds 200' do
      request.headers.merge!(@my_headers)
      post :create, params: {
        post: {
          message: 'A Post',
          wall_id: @user.id
        }
      }

      expect(response).to have_http_status(200)
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

end

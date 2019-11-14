require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before :each do
    post :create, params: { :user => { username: 'username', email: 'test@email.com', password: 'password' } }
  end

  describe 'POST /users' do
    it 'has status 200' do
      expect(response).to have_http_status(200)
    end

    it 'responds with failure' do
      post :create, params: { :user => { email: 'test@email.com', password: 'password' } }
      result = JSON.parse(response.body)
      failure_message = result['failure']['message']
      expect(failure_message).to eq("Validation failed: Email has already been taken, Username can't be blank")
      expect(response).to have_http_status(409)
    end

    it 'creates a user' do
      expect(User.find_by(email: 'test@email.com')).to be_a User
    end
  end
end

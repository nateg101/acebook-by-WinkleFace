require 'rails_helper'

RSpec.describe Api::V1::AuthsController, type: :controller do
  describe 'POST /auth' do
    it 'returns an authentication token' do
      User.create(username: 'username', email: 'test@user.com', password: 'password')
      post :create, params: { auth: {email: 'test@user.com', password: 'password' } }
      token = response.parsed_body['token']
      expect(token.length).to be > 0
    end
  end
end

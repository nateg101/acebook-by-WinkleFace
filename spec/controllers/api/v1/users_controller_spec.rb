require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before :each do
    post :create, params: { :user => {username: 'username', email: 'test@email.com', password: 'password'} }
  end

  describe 'POST /users' do
    it 'has status 200' do
      expect(response).to have_http_status(200)
    end
  end
end

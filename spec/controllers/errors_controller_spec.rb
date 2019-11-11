require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do

  before :each do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe 'user not found' do
    it 'raise error for user not found' do
      get :user_not_found
      expect(response).to have_http_status(200)
    end
  end

end

require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe 'POST /api/v1/posts' do
    it 'returns 200' do
      get :show
      puts "Request:"
      puts request.url
      puts response.headers
      puts response.redirect_url
      expect(response).to have_http_status(200)
    end

  end

end

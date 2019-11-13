require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    key = AuthenticateUserCommand.call(@user.email, @user.password).result
    @headers = { 
      "ACCEPT": "application/json",
      "Authorisation": key
    }
    @post = FactoryBot.create(:post)
  end
  describe 'POST #create' do
    it 'responds 201' do
      request.headers.merge(@headers)
      post :create, params: {
        comment: {
          message: 'A comment'
        },
        :post_id => @post.id
      }

      expect(response).to have_http_status(201)
    end

    it 'creates a comment' do
      request.headers.merge(@headers)
      post :create, params: {
        comment: {
          message: 'A comment'
        },
        :post_id => @post.id
      }

      expect(@post.comments.length).to eq 1
    end
  end

  describe 'PATCH #update' do
    before :each do
      @comment = Comment.create(post_id: @post.id, user_id: @user.id, message: "A comment")
    end
    it 'responds 200' do
      
      request.headers.merge(@headers)
      patch :update, params: {
        comment: {
          message: 'A new comment'
        },
        id: @comment.id,
        :post_id => @post.id
      }

      expect(response).to have_http_status(200)
    end

    it 'updates the comment' do
      request.headers.merge(@headers)
      patch :update, params: {
        comment: {
          message: 'A new comment'
        },
        id: @comment.id,
        :post_id => @post.id
      }

      expect(Comment.find(@comment.id).message).to eq 'A new comment'
    end

    it 'responds unauthorised unless user is comment owner' do
      user = User.create(username: 'new_user', email: 'new@user.com', password: 'password')
      key = AuthenticateUserCommand.call(user.email, user.password).result
      headers = { 
        "ACCEPT": "application/json",
        "Authorisation": key
      }
      request.headers.merge(headers)
      patch :update, params: {
        comment: {
          message: 'A new comment'
        },
        id: @comment.id,
        :post_id => @post.id
      }

      expect(response).to have_http_status(:unauthorized)
      expect(Comment.find(@comment.id).message).to eq 'A comment'
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @comment = Comment.create(post_id: @post.id, user_id: @user.id, message: "A comment")
    end
    it 'returns 200' do
      request.headers.merge(@headers)

      delete :destroy, params: {
        id: @comment.id,
        post_id: @post.id
      }

      expect(response).to have_http_status(200)
    end
  end
end

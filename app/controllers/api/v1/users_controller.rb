class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:create]

  def create
    begin
      user = User.create!(user_params)
      render json: { success: {} }
    rescue StandardError => e
      render json: { failure: { message: e.message } }, status: 409
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

end

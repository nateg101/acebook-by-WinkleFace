class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:create]

  def create
    puts user_params
    User.create(user_params)
    render json: { success: {} }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

end

class Api::V1::AuthsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    token_command = AuthenticateUserCommand.call(*auth_params.values)
    ## create an instance of AuthenticateUserCommand 
    ## and pulls out result from attr_accessor
    if token_command.success?
      user = User.find_by(email: auth_params[:email])
      render json: { success: { token: token_command.result, username: user.username } } 
    else
      render json: { failure: { message: token_command.errors } }, status: :unauthorized
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:email, :password)
  end

end

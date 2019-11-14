class Api::V1::AuthsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    token_command = AuthenticateUserCommand.call(*auth_params.values)
    ## create an instance of AuthenticateUserCommand 
    ## and pulls out result from attr_accessor
    if token_command.success?
      render json: { success: {token: token_command.result } } 
    else
      render json: { failure: {message: token_command.errors } }, status: :unauthorized
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:email, :password)
  end

end

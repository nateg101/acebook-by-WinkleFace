class Api::V1::AuthsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    puts params
    token_command = AuthenticateUserCommand.call(*auth_params.values)
    ## create an instance of AuthenticateUserCommand 
    ## and pulls out result from attr_accessor
    render json: { token: token_command.result } 
  end

  private

  def auth_params
    params.require(:auth).permit(:email, :password)
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  attr_reader :current_user

  rescue_from NotAuthorisedException, with: -> {
    render json: { error: 'Not Authorised' }, status: :unauthorized
  }

  protected

  private_methods
  def authenticate_user!
    @current_user = DecodeAuthenticationCommand.call(request.headers).result
    raise NotAuthorisedException unless @current_user
  end

end

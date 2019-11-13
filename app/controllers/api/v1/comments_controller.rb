class Api::V1::CommentsController < ApplicationController

  def create
    render json: { success: {} }, status: 201
  end

end

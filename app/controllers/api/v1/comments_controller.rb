class Api::V1::CommentsController < ApplicationController

  def create
    Comment.create(comment_params)
    render json: { success: {} }, status: 201
  end

  private

  def comment_params
    params.require(:comment)
      .permit(:message)
      .merge(user_id: current_user.id, post_id: params[:post_id])
  end

end

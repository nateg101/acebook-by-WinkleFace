class Api::V1::CommentsController < ApplicationController

  def create
    Comment.create(comment_params)
    render json: { success: {} }, status: 201
  end

  def update
    comment = Comment.find(params[:id])
    if current_user.owns?(comment)
      comment.message = comment_params[:message]
      comment.save!
      render json: { success: {} }, status: 200
    else
      raise NotAuthorisedException
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if current_user.owns?(comment)
      comment.destroy!
      render json: { success: {} }, status: 200
    else
      raise NotAuthorisedException
    end
  end

  private

  def comment_params
    params.require(:comment)
      .permit(:message)
      .merge(user_id: current_user.id, post_id: params[:post_id])
  end

end

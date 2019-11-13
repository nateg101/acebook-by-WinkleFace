class Api::V1::PostsController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:index]

  def index
    render json: Post.all
  end

  def create
    Post.create(create_post_params)
    render json: { success: {} }, status: 201
  end

  def update
    post = Post.find_by(update_post_params[:id])
    post.message = update_post_params[:message]
    post.save!
    puts Post.find_by(update_post_params[:id]).message
    render json: { success: {} }, status: 200
  end

  private

  def create_post_params
    params.require(:post).permit(:message, :wall_id).merge(user_id: current_user.id)
  end

  def update_post_params
    params.require(:post).permit(:message, :id).merge(user_id: current_user.id)
  end
end

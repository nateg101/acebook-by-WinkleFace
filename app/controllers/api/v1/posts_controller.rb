class Api::V1::PostsController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:show]

  def show
    render json: Post.all
  end

  def create
    Post.create(post_params)
    render json: { success: {} }
  end

  private

  def post_params
    params.require(:post).permit(:message, :wall_id).merge(user_id: current_user.id)
  end
end

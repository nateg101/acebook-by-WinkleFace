class Api::V1::PostsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    posts = Post.all.reverse unless params[:wall_id]
    posts = Post.where(wall_id: params[:wall_id]).reverse if params[:wall_id]

    render json: posts, :include => {
      :user => { :only => [:id, :username] },
      :get_likes => { :only => [:id] },
      :comments => {
         :only => [:message, :id, :user_id, :created_at, :updated_at],
        :include => { :user => { :only => [:id, :username] },
                      :get_likes => { :only => [:id] }
          }
      }
    }
  end

  def create
    Post.create(create_post_params)
    render json: { success: {} }, status: 201
  end

  def update
    post = Post.find_by(update_post_params[:id])
    raise NotAuthorisedException unless current_user.owns?(post)

    post.message = update_post_params[:message]
    post.save!
    render json: { success: {} }, status: 200
  end

  def destroy
    post = Post.find(params[:id])
    raise NotAuthorisedException unless current_user.owns?(post)

    post.destroy!
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

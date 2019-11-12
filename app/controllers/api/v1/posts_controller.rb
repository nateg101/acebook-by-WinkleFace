class Api::V1::PostsController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:show]

  def show
    render json: Post.all
  end
end

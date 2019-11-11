class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    if current_user
      redirect_to "/#{current_user.username}"
    else
      render 'devise/registrations/new'
    end
  end

end

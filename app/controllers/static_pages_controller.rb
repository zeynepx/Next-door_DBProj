class StaticPagesController < ApplicationController
  # This is a home action created in controller
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @neighbor_feeds = current_user.neighbor_feed.paginate(page: params[:page])
      @friend_feeds = current_user.friend_feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end


end


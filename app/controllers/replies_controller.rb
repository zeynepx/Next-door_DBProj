class RepliesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]


  def create
    @micropost = Micropost.find(session[:micropost_id])
    @reply = Reply.new(reply_params)

    if @reply.save
      flash[:success] = 'Replied'
      redirect_to ('/microposts/' + session[:micropost_id].to_s)
    else
      render 'static_pages/home'
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:content, :user_id, :micropost_id)
  end

end

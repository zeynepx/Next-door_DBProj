class RepliesController < ApplicationController

  def create
    #@reply = Reply.find(params[:id]
    @micropost = Micropost.find(session[:micropost_id])
    @reply = Reply.new(reply_params) #, @micropost.user_id, @micropost.id)

    #@reply = @micropost.replies.build
    #@reply = Reply.create(content: "s'up", micropost_id: 1, user_id: 1)
    #@reply = @micropost.replies.build
    #redirect_to '/microposts/1'
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

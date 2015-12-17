class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id], :status => "not_friend")
    if @friendship.save
      flash[:success] = "Friend Request Sent."
      redirect_to '/users/'# + current_user.id.to_s
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def update
    @friendship = Friendship.where(friend_id: current_user, user_id: params[:id]).first
    @friendship.update(:status => "friend")
    if @friendship.save
      flash[:success] =  "Successfully confirmed friend!"
      redirect_to current_user
    else
      redirect_to root_url, :notice => "Sorry! Could not confirm friend!"
    end
  end

  def destroy
    @friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendship.destroy
    flash[:success] = "Removed friendship."
    redirect_to '/users/' + current_user.id.to_s
  end


  def show
  end

end

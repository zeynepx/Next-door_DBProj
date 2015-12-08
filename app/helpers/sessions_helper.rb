module SessionsHelper

  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  def get_micropost_id(micropost)
    session[:micropost_id] = micropost.id
  end

  def current_micropost
    @current_micropost ||= Micropost.find_by(id:session[:micropost_id])
  end


  # Logs out the given user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  # Returns true if the given user is the current user
  def current_user?(user)
    user == current_user
  end

  # Redirect to stored location (or to the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwading_url)
  end

  # Stores the URL trying to be accessed
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  # def current_micropost
  #   @current_micropost ||= Micropost.find_by(id:session[:micropost_id])
  # end

end

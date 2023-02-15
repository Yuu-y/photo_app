module SessionsHelper
  def log_in(user)
    session[:user_id] = user.user_id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def current_user
    user_id = session[:user_id]
    if user_id
      @current_user ||= User.find_by(user_id: user_id)
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def current_user?(user)
    user == current_user
  end
end

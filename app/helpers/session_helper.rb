module SessionHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_out
    session.clear
    redirect_to '/', notice: 'logout successfully.'
  end
end

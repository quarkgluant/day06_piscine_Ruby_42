class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :admin?, :authenticate_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
    current_user.admin if current_user
  end

  def authenticate_user
    unless current_user
      flash['Vous devez d\'abord vous identifier']
      redirect_to home_path, notice: 'You need an account to see this'
      end
  end
end

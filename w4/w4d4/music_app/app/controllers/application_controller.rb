class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in
    @user = User.find_by(user_params)
    if @user.is_password?(params[:user][:password])
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_session_url
    end
  end

  def logged_in?(user)
    session[:session_token] == user.session_token
  end

  def must_be_logged_in
    redirect_to new_session_url if current_user.nil?
  end

  def user_params
    params.require(:user).permit(:email)
  end
end

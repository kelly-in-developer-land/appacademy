class UsersController < ApplicationController
  # before_action :ensure_logged_in, except: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @subs = Sub.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end

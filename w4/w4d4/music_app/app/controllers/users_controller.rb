class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.password = params[:password]
    if @user.save
      log_in
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    @user = User.find(params[:id])
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(session_params[:name], session_params[:password])
    if @user
      session[:session_token] = @user.session_token
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    session[:session_token] = nil
  end

  private

    def session_params
      params.require(:session).permit(:name, :password)
    end
    
end

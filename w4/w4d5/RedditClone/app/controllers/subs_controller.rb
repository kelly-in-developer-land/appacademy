class SubsController < ApplicationController
  before_action :ensure_moderator, except:[:new, :create]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save!
      redirect_to @sub
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.save!
      redirect_to @sub
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @sub = Sub.all.includes(posts: [:comments]).find(params[:id])
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

  def ensure_moderator
    Sub.find(params[:id]).moderator == current_user
  end
end

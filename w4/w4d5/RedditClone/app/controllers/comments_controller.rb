class CommentsController < ApplicationController

  before_action :ensure_commenter, except:[:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.commenter = current_user
    if @comment.save!
      flash[:notice] = "Created comment!"
      redirect_to :back
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  # def edit
  #   @comment = Comment.find(params[:id])
  # end
  #
  # def update
  #   @comment = Comment.find(params[:id])
  #   if @comment.save!
  #     redirect_to sub_post_url(@comment.commentable_id)
  #   else
  #     flash[:errors] = @comment.errors.full_messages
  #     redirect_to :back
  #   end
  # end

  # def show
  #   @comment = Comment.find(params[:id])
  # end

  private

  def comment_params
    params.require(:comment).permit(:content, :commenter_id, :commentable_id, :commentable_type)
  end

  def ensure_commenter
    Comment.find(params[:id]).commenter == current_user
  end
end

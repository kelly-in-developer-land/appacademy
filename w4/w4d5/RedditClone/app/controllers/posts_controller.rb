class PostsController < ApplicationController

  before_action :ensure_author, except:[:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save!
      params[:post][:sub_ids].each do |sub_id|
        PostSub.create!(post_id: @post.id, sub_id: sub_id)
      end
      flash[:notice] = "Created post!"
      redirect_to sub_url(params[:sub_id])
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.save!
      redirect_to sub_url(params[:sub_id])
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to :back
    end
  end

  # def show
  #   @post = Post.find(params[:id]).includes(:comments)
  # end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :author_id)
  end

  def ensure_author
    Post.find(params[:id]).author == current_user
  end

end

class PostsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to '/posts'
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.update(post_params)
      flash[:notice] = 'Post edited successfully'
    else 
      flash[:notice] = 'Cannot edit post'
    end
    redirect_to '/posts'
  end

  def destroy
     @post = Post.find(params[:id])
    if current_user == @post.user
      @post.destroy
      flash[:notice] = 'Post deleted successfully'
    else
      flash[:notice] = 'Cannot delete post'
    end
    redirect_to '/posts'
  end

  def post_params
    params.require(:post).permit(:name, :image, :description)
  end
end

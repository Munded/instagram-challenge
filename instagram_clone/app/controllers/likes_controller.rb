class LikesController < ApplicationController
  before_action :authenticate_user!, :except => [:show]

  def new
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build_with_user(current_user)
    if @like.save
      redirect_to posts_path
    elsif @like.errors[:user]
      redirect_to posts_path, alert: 'You have already liked this post'
    else
      render :new
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    flash[:notice] = 'Post has been unliked'
    redirect_to '/posts'
  end
end

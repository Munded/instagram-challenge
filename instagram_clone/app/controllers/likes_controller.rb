class LikesController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.create
    like.user = current_user
    redirect_to restaurants_path
  end
end

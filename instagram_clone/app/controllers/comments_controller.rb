class CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:show]

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def show
    @post = Post.find(params[:post_id])
    @comment = @post.comment.find(params[:id])
  end


  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user
    comment.save
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.update(comment_params)
      flash[:notice] = 'comment edited successfully'
    else 
      flash[:notice] = 'Cannot edit comment'
    end
    redirect_to '/posts'
  end

  def destroy
     @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.destroy
      flash[:notice] = 'Comment deleted successfully'
    else
      flash[:notice] = 'Cannot delete comment'
    end
    redirect_to '/posts'
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end

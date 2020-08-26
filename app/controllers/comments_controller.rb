class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :delete, :destroy]

  def create
    @comment = Comment.create(comment_params)
  end

  def edit
    #@comment = Comment.find_by(id: params[:id])
    @post = Post.find_by(id: @comment.post_id)

    if @comment.user_id != @user.id
      flash[:alert] = "⚠️ You can't edit other users comments."
      redirect_to home_path
    end

  end

  def update
    #@comment = Comment.find_by(id: params[:id])
    @post = Post.find_by(id: @comment.post_id)

    if @comment.update(comment_params)
      redirect_to @post
    else
      flash.now[:alert] = "⚠️ Changes not saved."
      render :edit
    end
  end

  def destroy
    #byebug
    @post = Post.find_by(id: @comment.post_id)
    @comment.delete
    flash[:alert] = " ✅ Comment has been deleted"
    redirect_to @post
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end
end

class PostsController < ApplicationController
before_action :set_post, only: [:show, :edit, :update, :delete, :destroy]

  def new
    if logged_in? 
      @post = Post.new
    else
      flash[:alert] = "⚠️ Please log in to create a new post."
      redirect_to login_path
    end
  end

  def create
    @post = Post.create(post_params)
    redirect_to @post
  end

  def index
    if params[:user_id]
      @search_user = User.find_by(id: params[:user_id])
      if !@search_user.nil?
        @posts = @search_user.posts
      else
        redirect_to home_path, alert: "⚠️ User not found"
      end
    else
      @posts = Post.all
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
    @post = Post.find_by(id: params[:id]) 
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      flash.now[:alert] = "⚠️ Changes not saved."
      render :edit
    end
  end


  def destroy
    @post.delete
    flash[:alert] = " ✅ Post has been deleted"
    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :title, :content, :all_tags)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end

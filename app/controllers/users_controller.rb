class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :new
    end
  end

  def home
  end

  def edit_tags
    if !logged_in?
      redirect_to login_path 
      flash[:alert] = "⚠️ Please log in to save your preferences."
    end
  end

  def update_tags
      @user.update(user_tag_params)
  end


  private

  def user_params
    params.require(:user).permit(:email, :username, :name, :password, :password_confirmation)
  end

  def user_tag_params
    params.require(:user).permit(tag_ids:[])
  end
end

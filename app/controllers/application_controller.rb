class ApplicationController < ActionController::Base
    before_action :current_user
    helper_method :logged_in?

    def current_user
        @user = User.find_by(id: session[:user_id]) || User.new
    end

    def logged_in?
        !!session[:user_id]
    end

    def require_login
        unless logged_in?
            flash[:error] = "You must be logged in to access this section."
            redirect_to login_path
        end
    end
end

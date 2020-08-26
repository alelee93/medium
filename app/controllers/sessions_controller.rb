class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:user][:email])
        user = user.try(:authenticate, params[:user][:password])

        if user
            session[:user_id] = user.id
            @user = user
            redirect_to home_path
        else
            flash.now[:alert] = "Incorrect email or password."
            render :'sessions/new'
        end
    end

    def create_with_omniauth
        omniauth = request.env['omniauth.auth']['info']
        @user = User.find_or_create_by(email: omniauth["email"]) do |user|
            user.name = omniauth["name"]
            user.username = omniauth["name"]
            user.password = SecureRandom.hex
        end
        session[:user_id] = @user.id
        redirect_to home_path
    end

    def destroy
        session[:user_id] = nil
        redirect_to signup_path
    end
end

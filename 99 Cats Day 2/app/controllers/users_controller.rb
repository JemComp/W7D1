class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        @user.password = params[:user][:password]
        debugger
        if @user.save
            login!(@user)
            redirect_to cats_url
        else
            render json: @user.errors.full_messages, status: 404
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password_digest)
    end
end


class SessionsController < ApplicationController
    def create
        @user = user.find_by_credentials(params[:user][:username], params[:user][:password])

        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    def destroy!
        logout!
    end


end

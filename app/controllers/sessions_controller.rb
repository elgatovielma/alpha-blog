class SessionsController < ApplicationController

    #This for showing the form
    def new
    end

    #This is for logging in the user
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            # session[:user_id] saves the current user 
            # that's been authenticated in the browser's cookies
            session[:user_id] = user.id
            flash[:success] = "You have successfully logged in"
            redirect_to user_path(user)
        else
            # .now because we are not sending a request to the server
            flash.now[:danger] = "There was something wrong with your logging info"
            render 'new'
        end
    end

     #This is for logging out the user
    def destroy
        # We clean the current user from the browser's cookies
        session[:user_id] = nil
        flash[:success] = "You have successfully logged out"
        redirect_to root_path
    end

end
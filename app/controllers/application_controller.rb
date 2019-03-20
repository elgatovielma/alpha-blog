class ApplicationController < ActionController::Base

    # it allows your views to use these methods
    helper_method :current_user, :logged_in?

    def current_user
        # If it's the current user, don't check the DB, otherwise fetch the indicated user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    def require_user
        if !logged_in?
            flash[:danger] = "You must be logged in to perfom that action"
            redirect_to root_path
        end
    end

end

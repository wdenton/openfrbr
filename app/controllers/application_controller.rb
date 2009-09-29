class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '89f94784438a58c11b23195990acead5'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data
  # parameters from your application log (in this case, all fields
  # with names like "password").
  # filter_parameter_logging :password

  # AuthLogic
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
      # @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end
 
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

  # def edit_in_place
  #   @thing_to_edit = params[:type].to_class.find(params[:id])
  #   @thing_to_edit.send "#{params[:field]}=", params[:value]
  #   @thing_to_edit.save
  #   render :text => params[:value]
  # end

end

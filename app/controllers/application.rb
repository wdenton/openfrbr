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

  # def edit_in_place
  #   @thing_to_edit = params[:type].to_class.find(params[:id])
  #   @thing_to_edit.send "#{params[:field]}=", params[:value]
  #   @thing_to_edit.save
  #   render :text => params[:value]
  # end

end

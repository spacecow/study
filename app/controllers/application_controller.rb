class ApplicationController < ActionController::Base
  include BasicApplicationController

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = alertify(:unauthorized_access)
    flash[:alert] = exception.message
    if current_user
      redirect_to welcome_url
    else
      session[:original_url] = request.path  
      redirect_to root_url
    end
  end

  protect_from_forgery

  helper_method :jt, :current_user

end

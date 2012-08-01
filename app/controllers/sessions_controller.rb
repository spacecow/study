class SessionsController < ApplicationController
  def create
    user = User.authenticate_from_omniauth(env["omniauth.auth"])
    #user = User.last
    session_userid(user.id)
    flash[:notice] = notify(:signed_in)
    if session_original_url
      url = session_original_url
      session_original_url(nil)
      redirect_to url and return
    end
    redirect_to root_url
  end

  def destroy
    session_userid(nil)
    redirect_to root_url, :notice => notify(:signed_out)
  end
end

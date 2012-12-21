class SessionsController < ApplicationController
  def create
    #if env["omniauth.auth"]
    #  user = User.authenticate_from_omniauth(env["omniauth.auth"])
    #else
    #  # regular login
    #end
    auth = Authentication.new(params, env["omniauth.auth"])
    #user = User.create
    if auth.authenticated?
      session_userid(auth.user.id)
      flash[:notice] = notify(:signed_in)
      if session_original_url
        url = session_original_url
        session_original_url(nil)
        redirect_to url and return
      end
      redirect_to root_url
    else
      # login failed
    end
  end

  def destroy
    session_userid(nil)
    redirect_to root_url, :notice => notify(:signed_out)
  end
end

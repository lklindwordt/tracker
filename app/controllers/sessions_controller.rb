class SessionsController < ApplicationController
  layout "login"
  
  def new
    if current_user
      redirect_to root_path
    end
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token ] = user.auth_token
      else
        cookies[:auth_token ] = user.auth_token
      end
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new" 
    end
  end
  
  def destroy 
    cookies.delete(:auth_token)
    redirect_to login_path, :notice => "Logged out! "
  end
end
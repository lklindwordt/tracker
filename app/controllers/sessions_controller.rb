class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  
  def new
    if current_user
      redirect_to root_path
    end
  end
  
  def create
    user = User.find_by_email(params[:email])
    
    success = authenticate user
    token = form_authenticity_token
    
    respond_to do |format|
      if success
        format.html { redirect_to root_url, :notice => "Logged in!" }
        format.js { render json: { success: true, authToken: token, session: cookies[:auth_token] } }
      else
        format.html { 
          flash.now.alert = "Invalid email or password"
          render "new"
        }
        format.js { render json: { success: false } }
      end
    end
    logger.debug form_authenticity_token
  end
  
  def destroy 
    cookies.delete(:auth_token)
    redirect_to login_path, :notice => "Logged out! "
  end
  
  protected
  def authenticate user
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token ] = user.auth_token
      else
        cookies[:auth_token ] = user.auth_token
      end
      true
      
    else
      false
    end
  end
end
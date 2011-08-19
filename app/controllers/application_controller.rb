class ApplicationController < ActionController::Base
  before_filter :load_projects
  protect_from_forgery
  
  def authenticate_user!
    if current_user.nil?
      redirect_to login_url, :alert => "You must first log in to access this page"
    end
  end
  
  private 
    def load_projects
      @projects = Project.all
    end
    
    def current_user
      @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
    end 
    helper_method :current_user
end

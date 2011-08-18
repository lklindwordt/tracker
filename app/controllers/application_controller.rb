class ApplicationController < ActionController::Base
  before_filter :load_projects
  protect_from_forgery
  
  private 
    def load_projects
      @projects = Project.all
    end
end

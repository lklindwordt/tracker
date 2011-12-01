class ApplicationController < ActionController::Base
  before_filter :load_projects
  after_filter :add_xhr_response_header

  protect_from_forgery

  private
    def load_projects
      @projects = Project.all
    end

  def add_xhr_response_header
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT'
  end
end

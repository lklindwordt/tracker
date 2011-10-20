class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  helper_method :project

  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: project }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: project }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if project.save
        format.html { redirect_to project, notice: 'Project was successfully created.' }
        format.json { render json: project, status: :created, location: project }
      else
        format.html { render action: "new" }
        format.json { render json: project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if project.update_attributes(params[:project])
        format.html { redirect_to project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end

  protected
  def project
    if params.has_key(:id)
      Project.find params[:id]
    else
      Project.new params[:project]
    end
  end
end

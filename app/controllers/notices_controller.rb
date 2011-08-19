class NoticesController < ApplicationController
  before_filter :authenticate_user!, :except => ['extern']
  
  # GET /notices
  # GET /notices.json
  def index
    @notices = Notice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notices }
      format.js { render json: @notices }
    end
  end

  # GET /notices/1
  # GET /notices/1.json
  def show
    @notice = Notice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notice }
    end
  end

  # GET /notices/new
  # GET /notices/new.json
  def new
    @notice = Notice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notice }
    end
  end

  # GET /notices/1/edit
  def edit
    @notice = Notice.find(params[:id])
  end

  # POST /notices
  # POST /notices.json
  def create
    @notice = Notice.new(params[:notice])

    respond_to do |format|
      if @notice.save
        format.html { redirect_to @notice, notice: 'Notice was successfully created.' }
        format.js { render json: @notice, status: :created, location: @notice }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /notices/1
  # PUT /notices/1.json
  def update
    @notice = Notice.find(params[:id])

    respond_to do |format|
      if @notice.update_attributes(params[:notice])
        format.html { redirect_to @notice, notice: 'Notice was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notices/1
  # DELETE /notices/1.json
  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy

    respond_to do |format|
      format.html { redirect_to notices_url }
      format.json { head :ok }
    end
  end
  
  #TODO identify user and create new user
  def extern     
    #params[:notice] = '	{"note":"ydf","element":"foo","url":"http://stackoverflow.com/questions/2384561/ruby-on-rails-form-page-caching-including-authenticity-token","position":"0,0"}'
    
    hash = JSON.parse params[:notice]
    url = hash["url"]
    logger.debug("DEBUG-AUSGABE:")
    #logger.debug(hash)
    #logger.debug(url)
    if url =~ /^http:\/\/(.+)\.(.+)\//
      url = "#{$1}.#{$2.split('/').first}"
    end
    logger.debug(url)
    @project = Project.where(["url LIKE ?", "%#{url}%"]).first
    if @project
      @notice = Notice.new(hash.merge({:project_id => @project.id}))
      if @notice.save
        @responseobj = {'status' => 'success', 'message' => 'Notice saved.'}
      else
        @responseobj = {'status' => 'error', 'message' => 'Notice not saved.'}
      end
    else  
      #location = request.subdomain
      @responseobj = {'status' => 'error', 'message' => 'No project found.'}
      
    end  
    respond_to do |format|  
      format.json { render :json => @responseobj, :status => 200 }
    end
  end
end

class SharedFilesController < ApplicationController
	require_role 'user',:only => [:new,:edit,:create,:update,:destroy]
  before_filter :find_sharedFile, :only => [:show, :edit, :update]
 after_filter :increment_down,:only => [:download]
  # GET /sharedFiles
  # GET /sharedFiles.xml
  def index
    @shared_file = SharedFile.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @shared_file }
    end
  end

  # GET /sharedFiles/1
  # GET /sharedFiles/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @shared_file }
    end
  end

  # GET /sharedFiles/new
  # GET /sharedFiles/new.xml
  def new
    @shared_file = SharedFile.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @shared_file }
    end
  end

  # GET /sharedFiles/1/edit
  def edit
  end

  # POST /sharedFiles
  # POST /sharedFiles.xml
  def create
    @shared_file = SharedFile.new(params[:shared_file])

    respond_to do |wants|
      if @shared_file.save
        flash[:notice] = 'SharedFile was successfully created.'
        wants.html { redirect_to(@shared_file) }
        wants.xml  { render :xml => @shared_file, :status => :created, :location => @shared_file }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @shared_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sharedFiles/1
  # PUT /sharedFiles/1.xml
  def update
    respond_to do |wants|
      if @shared_file.update_attributes(params[:shared_file])
        flash[:notice] = 'SharedFile was successfully updated.'
        wants.html { redirect_to(@shared_file) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @shared_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sharedFiles/1
  # DELETE /sharedFiles/1.xml
  def destroy
    current_user.shared_files.find(params[:id]).destroy

    respond_to do |wants|
      wants.html { redirect_to(shared_files_url) }
      wants.xml  { head :ok }
    end
  end
	def download
		
	end
	def fileupload
		
	end
	
  private
    def find_sharedFile
      @shared_file = SharedFile.find(params[:id])
    end

end
class SharedResourcesController < ApplicationController
	require_role 'user',:only => [:new,:edit,:create,:update,:destroy,:download]
  before_filter :find_sharedFile, :only => [:show, :edit, :update]
 after_filter :increment_down,:only => [:download]
  # GET /sharedFiles
  # GET /sharedFiles.xml
  def index
    @shared_resource = SharedResource.find_by_category('dianzishu').limited(20)

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @shared_resource }
    end
  end

  # GET /sharedFiles/1
  # GET /sharedFiles/1.xml
  def show
	@shared_resource=SharedResource.find(params[:id])
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @shared_resource }
    end
  end

  # GET /sharedFiles/new
  # GET /sharedFiles/new.xml
  def new
    @shared_resource = SharedResource.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @shared_resource }
    end
  end

  # GET /sharedFiles/1/edit
  def edit
  end

  # POST /sharedFiles
  # POST /sharedFiles.xml
  def create
    @shared_resource = SharedResource.new(params[:shared_resource])
@shared_resource.user=current_user
@shared_resource.shared_files << SharedFile.find(params[:attach]) unless params[:attach].blank?
t = Tempfile.new("#{Time.now.to_s}-#{request.remote_ip}")
Zip::ZipFile.open(t.path, Zip::ZipFile::CREATE) { |zf|
	@shared_resource.shared_files.each{|f|
	zf.add f.file_file_name,f.file.url
	}
	
	}
@shared_resource.zip_file 

    respond_to do |wants|
      if @shared_resource.save
        flash[:notice] = '分享资源成功！'
        wants.html { redirect_to(@shared_resource) }
        wants.xml  { render :xml => @shared_resource, :status => :created, :location => @shared_resource }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @shared_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sharedFiles/1
  # PUT /sharedFiles/1.xml
  def update
    respond_to do |wants|
      if @shared_resource.update_attributes(params[:shared_resource])
        flash[:notice] = '修改资源成功！'
        wants.html { redirect_to(@shared_resource) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @shared_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sharedFiles/1
  # DELETE /sharedFiles/1.xml
  def destroy
    current_user.shared_resources.find(params[:id]).destroy

    respond_to do |wants|
      wants.html { redirect_to(shared_resources_url) }
      wants.xml  { head :ok }
    end
  end
	def download
		
	end
	  def fileupload
	    am=SharedFile.new :file=>params[:Filedata]
		am.user=current_user
		mime_type = MIME::Types.type_for(am.file_file_name)    
		am.file_content_type = mime_type.first.content_type.to_s if mime_type.first
	    am.save!
	    render :text=>"FILEID:"+am.id.to_s
	  end
	def ie6_patch
		render :text => current_user.shared_files.find_by_file_file_name(params[:file_name]).id
	end
  private
    def find_sharedFile
      @shared_resource = SharedResource.find(params[:id])
    end

end
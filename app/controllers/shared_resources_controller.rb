class SharedResourcesController < ApplicationController
	require_role 'user',:only => [:new,:edit,:create,:update,:destroy]
  before_filter :find_sharedFile, :only => [:show, :edit, :update]
 	after_filter :increment_page_views,:only => [:show]
include PageViews::Controller
  # GET /sharedFiles
  # GET /sharedFiles.xml
  def index
    # @shared_resources = SharedResource.limited(20)

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @shared_resources }
    end
  end
  def list
	@shared_resources=SharedResource.category_equals(params[:type]).paginate(:per_page => 30,:page => params[:page])
	
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
t = Tempfile.new(["#{Time.now.to_s}-#{request.remote_ip}",'.zip'])
Zippy.create(t.path) do |zip|
	@shared_resource.shared_files.each{|f|
  zip["#{f.file_file_name}"] =  File.open(f.file.path)
}
end
# Zip::ZipOutputStream.open(t.path) { |zf|
# 	@shared_resource.shared_files.each{|f|
# 	zf.add f.file_file_name,f.file.url
# 	}
# 	
# 	}
@shared_resource.add_file t
t.close
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
		if logged_in? && current_user.has_role?('user')
		@shared_resource=SharedResource.find(params[:id])
		@shared_resource.down_count+=1
		@shared_resource.save
		# @shared_resource.down_count=1 unless @shared_resource.down_count
		send_file 	@shared_resource.zip_file.path,:type => 'application/zip',:filename => @shared_resource.title+".zip"
		else
				flash[:notice]="您需要登录后才能进行此次操作。"
				redirect_to login_url
		end
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
	def tagged
		@shared_resources=SharedResource.tagged_with(Tag.find(params[:id]).name,:on => :tags).paginate(:page => params[:page], :per_page => 30)
		render :action => :list
	end
	
  private
    def find_sharedFile
      @shared_resource = SharedResource.find(params[:id])
    end
	def increment_down
	  # @shared_resource.down_count ||+=1  #load @post before
	end
	def increment_page_views
  		page_views_increment @shared_resource  #load @post before
  	end
end
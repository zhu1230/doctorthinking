class PagesController < ApplicationController
	# layout false,:except => [:about_us]
	 skip_before_filter :store_location,:except => :about_us
def privacy
		render :layout => false
end
def terms
		render :layout => false
end
def about_us
	render :layout => true
end

  def show
    @page = Page.find_by_name(params[:name])
    @page_name = @page.name
    if current_user
      @user = current_user
    end
  end
  
  
  def create
    @page = Page.new(params[:page])
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/pages')
          else
            redirect_to(@page) 
          end  
        }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @page = Page.find(params[:id])
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/pages')
          else
            redirect_to(@page) 
          end  
         }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end
  
  
end

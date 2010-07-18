class WallPostsController < ApplicationController

  uses_tiny_mce :options => {
                              :theme => 'advanced',
                              :theme_advanced_toolbar_location => "top",
                              :theme_advanced_toolbar_align => "left",
                              :theme_advanced_resizing => true,
                              :theme_advanced_resize_horizontal => false,
                              :theme_advanced_buttons1 => "forecolor,backcolor,bullist,numlist,separator,outdent,indent,separator,undo,redo,separator,link,unlink,anchor,image,cleanup,help,code",
                              :theme_advanced_buttons2 => "",
                              :theme_advanced_buttons3 => ""
                            }
                            
                            
 require_role "user", :only => [:new, :edit, :create, :update]
  

  def create
    @wall_post = WallPost.new(params[:wall_post])
    if params[:group_id]
      @wall_post.group_id = params[:group_id]
    elsif params[:event_id]
      @wall_post.event_id = params[:event_id]
    else
      @wall_post.user_id = params[:user_id]
    end
    @wall_post.sender_id = current_user.id
 @wall_post.user_id = current_user.id
    respond_to do |format|
      if @wall_post.save
        flash[:notice] = 'WallPost was successfully created.'
        set_parent
        format.html { 
          render :partial => 'shared/wall_posts', :locals=>{:parent=>@parent}, :layout=>false 
        }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @wall_post = WallPost.find(params[:id])
    respond_to do |format|
      if @wall_post.update_attributes(params[:wall_post])
        flash[:notice] = 'WallPost was successfully updated.'
        format.html { redirect_to(@wall_post) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wall_post.errors, :status => :unprocessable_entity }
        format.json  { render :json => @wall_post.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @wall_post = WallPost.find(params[:id])
    set_parent
    @wall_post.destroy
    respond_to do |format|
      format.html { render :partial => 'shared/wall_posts', :locals=>{:parent=>@parent}, :layout=>false }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  
  private
  
  def set_parent
    if @wall_post.group_id
      @parent = Group.find(@wall_post.group_id)
    elsif @wall_post.event_id
       @parent = Event.find(@wall_post.event_id)
    else
      @user = User.find(@wall_post.user_id)
      @parent = @user
    end  
  end
  
  
end

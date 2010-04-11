#   Copyright 2009 Timothy Fisher
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

class UsersController < ApplicationController
    include AuthenticatedSystem
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
  
 require_role "user", :only => [:edit, :update]
  
  	def forgot  
	  if request.post?  
	    user = User.find_by_email(params[:user][:email])  

	    respond_to do |format|  
	      if user  
	        user.create_reset_code  
	        flash[:notice] = "重设密码的链接已经发送到 #{user.email}"  

	        format.html { redirect_to login_url }  
	        format.xml { render "<img src=\"http://net.tutsplus.com/wp-includes/images/smilies/icon_mad.gif\" alt=\":x\" class=\"wp-smiley\">",ml => user.email, :status => :created }  
	      else  
	        flash[:error] = "#{params[:user][:email]} 不存在，请重新尝试"  

	        format.html { redirect_to forgot_url }  
	        format.xml { render "<img src=\"http://net.tutsplus.com/wp-includes/images/smilies/icon_mad.gif\" alt=\":x\" class=\"wp-smiley\">", ml => user.email, :status => :unprocessable_entity }  
	      end  
	    end  

	  end  
	end
	
	
	def reset  
	  @user = User.find_by_password_reset_code(params[:reset_code]) unless params[:reset_code].nil?  
	  if request.post?  && @user
	    if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])  
	      self.current_user = @user  
	      @user.delete_reset_code  
	      flash[:notice] = "密码重设成功，您的邮件为 #{@user.email}"  
	      redirect_to index_url  
	    else  
	      render :action => :reset  
	    end  
	  end  
	end
	
	
  # Called from the blog settings of the 'My Blog' widget on a user page
  # this sets an RSS feed URL for mirroring
  def update_blog_feed_url
    url = params[:url]  
    render :partial=>'users/blog_posts_widget', :layout=>false
  end

  
  def grid_data_old
    @users = User.find(:all)
    respond_to do |format|
      format.xml { render :partial => 'users/griddata.xml.builder', :layout=>false }
    end
  end
  
  
  # Returns a list of users in a JSON array.  This is used to display
  # the DOJO grid for the admin page.
  def grid_data
    @users = User.find(:all, :select=>'id, first_name, last_name')
    render :json => @users.to_json
  end
  
  
  # Register all existing users with Facebook
  # Should only be required to run once, afterward all new users will be registered at creation time.
  def fb_register_all_users
    User.find(:all).each do |user|
      user.register_user_to_fb
    end
  end

  
  # Called after a user logs in via Facebook Connect
  def link_facebook_account
    if self.current_user.nil?
      # no local user, so create a new local user account
      # seems like a user who already exists locally, but not yet linked to facebook would also take this path
      #  (unless he was registered to facebook which would set his email hash allowing the login_by_facebook to log
      #   him in)
      if (facebook_session)
        @user = User.new
        @user.facebook_id = facebook_session.user.id
        render :partial => 'facebook_user_form', :layout=>true
      end
    else
      # local user account exists, link the facebook account with local account
      # seems like this path would only be taken when local user is already linked to facebook user
      # could be reached if user already locally logged in connects with facebook
      # of if a user has been registered to facebook, but not connected yet
      self.current_user.link_fb_connect(facebook_session.user.id) unless self.current_user.facebook_id == facebook_session.user.id
      redirect_to '/'
    end
  end
  
  
  def promote_to_group_admin
    user_id = params[:user_id]
    group_id = params[:group_id]
    Membership.find_by_user_and_group(user_id, group_id)
  end
  
  
  def demote_from_group_admin
    
  end
  
  
  # Called to show the 'Members' page or the members of a group page
  def index
    @section = 'MEMBERS' 
    if params[:group_id] == nil
      display_members_list_page
    else
      display_group_members_page
    end
  end
  
  
  def display_members_list_page
    sort = params[:sort_field]      
    @sort_field = sort || 'created_at'
    respond_to do |format|
      format.html {
        @users = User.paginate(:all, :page => params[:page], :conditions => "activated_at is not null", 
                               :include=>[:profile_photo, :state, :country], :order => @sort_field + ' ASC') 
        @user_count = User.cached_count
      }
      format.xml  { 
        @users = get_users_for_api
        render :xml => @users 
      }
      format.json {
        @users = get_users_for_api
        render :json => @users
      }
    end
  end
  
  
  def display_group_members_page 
    @group = Group.find(params[:group_id])
    @users = @group.users
    respond_to do |format|
      format.html { render :template => 'groups/manage_group_users' }
      format.xml  { render :xml => @users.to_xml(:dasherize => false) }
      format.json  { render :json => @users.to_json(:dasherize => false) }
    end
  end
  
  
  def get_users_for_api
    filters = get_filter
    filter_str = build_filter_string(filters) 
    if filter_str.length > 0
      conditions = "activated_at is not null AND " + filter_str
    else
      conditions = "activated_at is not null"
    end
    if params[:limit]
      offset = params[:offset] || 0
      limit = params[:limit] 
      @users = User.find(:all, 
                         :select=>get_users_xml_select, 
                         :conditions => conditions, 
                         :limit=>limit, 
                         :offset=>offset, 
                         :order => @sort_field + ' ASC') 
    else
      @users = User.find(:all, 
                         :select=>get_users_xml_select, 
                         :conditions => conditions, 
                         :order => @sort_field + ' ASC') 
    end
    @users
  end
  
  
  def get_filter
    attrs = User.column_names
    filters = []
    params.each {|key,value|
      next if key == 'api_key'
      if attrs.include?(key) 
        filters << key
      end
     }
     filters
  end
  
  
  def build_filter_string(filters) 
    result = ''
    filters.each do |filter|
      result += ' AND ' unless result == ''
      result += filter + "='" + params[filter] + "'" 
    end
    result
  end
  
  
  # Called to display a user page, including the 'My Page' page.
  # Most content loaded onto the page as AJAX widgets
  def show   
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { 
        if (current_user && (current_user.id.to_s == params[:id].to_s))
          @section = 'profile'
        else 
          @section = 'MEMBERS'
        end
        @page_name = 'profile'
        if @user.twitter_id && @user.display_tweets
          @tweets = @user.fetch_tweets
        end
      }
      format.xml { render :xml => @user.to_xml(:dasherize => false) }
      format.json { render :json => @user.to_json }
    end
  end


  def new
    @invite_code = params[:invite_code]
    @user = User.new
  end

  
  def edit
    if (params[:id].to_s != current_user.id.to_s)
      # can only edit your own page
      redirect_back_or_default('/')
    end
    @user = User.find(params[:id])
  end


  def create_facebook_user
    if facebook_session
      User.create_from_fb_connect(facebook_session.user, @user.email, @user.login, @user.first_name, @user.last_name)
      flash[:notice] = "Thanks for signing up!"
    end
    redirect_to '/'
  end




  
  
  def create
   logout_keeping_session!
	#params[:user]['keshi_id']=1
    @user = User.new(params[:user])
    # if @user.facebook_id
    #   create_facebook_user
    # else
      # create just a local user
      # sleep 4  # required for photo upload
      cookies.delete :auth_token
      @user.roles << Role.find_by_rolename('user')
	  success = @user && @user.save
    if success && @user.errors.empty?
        if params[:invite_code]
          Invite.accept(params[:invite_code]) 
        end
        # @user.set_photo(params[:user_photo])
        respond_to do |format|
          format.html {
		 # self.current_user = @user # !! now logged in
      #redirect_back_or_default('/')
            flash.now[:notice] = "感谢您的注册！"
            render :template=>'sessions/signup_thankyou'
          }
          format.xml {
            if !Configuration.REQUIRE_ACTIVATE_FOR_USER_CREATE_VIA_API
              @user.activate
            end
            render :xml => @user, :status => :created, :location => @user
          }
          format.json {
            if !Configuration.REQUIRE_ACTIVATE_FOR_USER_CREATE_VIA_API
              @user.activate
            end
            render :json => @user.to_json, :status => :created, :location => @user
          }
        end
      else
        respond_to do |format|
          format.html {
            render :action => 'new'
          }
          format.xml {
            render :xml => @user.errors, :status => 'failed'
          }
          format.json {
            render :json => @user.errors, :status => 'failed'
          }  
        end
      end
    #end
  end

  def update
    if (params[:id].to_s != current_user.id.to_s)
      redirect_back_or_default('/')
    end
    sleep 4  # required for photo upload
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])        
        if params[:user_photo] && params[:user_photo].size != 0 
          # remove old profile photos
          Photo.destroy_all("user_id = " + @user.id.to_s + " AND is_profile = true")
          profile_photo = ProfilePhoto.create!(:user_id=>@user.id, :is_profile=>true, :uploaded_data => params[:user_photo]) if params[:user_photo].size != 0 
          @user.profile_photo = profile_photo
        end  
        
        flash[:notice] = '用户已成功更新.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/users')
          else
            redirect_to(@user) 
          end         
        }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.json  { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "感谢您激活您的帐号，现在您可以完全参与到医思网社区中。"
      # render :template=>'users/activate_complete'
	
	redirect_to :controller=>"/user",:action=>"index"
    else
      redirect_back_or_default('/')
    end
  end
  
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to('/') } 
      format.xml { head :ok } 
      format.json { head :ok } 
    end
  end
  
  
  # Function: authenticate
  #  Authenticates user with given login and password.
  #  Does not create session. Returns user object on
  #  successful auth.
  def authenticate
    self.current_user = User.authenticate(params[:login], params[:password])
    if (self.current_user.nil?)
      # respond with error output
      respond_to do |format|
        format.html {
          flash[:notice] = "用户名或密码错误"
          render :action => 'new'
        }
        format.xml {
          data = {:message => "用户名或密码错误"}
          render :xml => data.to_xml(:dasherize => false), :status => 403
        }
        format.json {
          data = {:message  => "用户名或密码错误"}
          render :json => data.to_json(:dasherize => false), :status => 403
        }
      end
    else
      # valid authentication
      # increment count for user login
      login_count = self.current_user.login_count
      login_count = login_count + 1
      self.current_user.update_attribute('login_count', login_count)
      self.current_user.update_attribute('last_seen_at',Time.zone.now)
      
      # respond with output
      respond_to do |format|
        format.html {
          redirect_back_or_default('/')
          flash[:notice] = "Logged in successfully"
        }
        format.xml {
          render :xml => self.current_user.to_xml(:dasherize => false)
        }
        format.json {
          render :json => self.current_user.to_json(:dasherize => false)
        }
      end
    end 
  end
  
  
  private
  def get_users_xml_select
    'id, first_name, last_name, login, sex, city, state_id, zip, country_id, 
    phone, phone2, time_zone, about_me, organization, skills, occupation, featured,
    website, blog, blog_feed, flickr, flickr_username, linked_in_url, twitter_id, aim_name,
    gtalk_name, yahoo_messenger_name, msn_name, youtube_username, skype_name, posts_count,
    last_seen_at, login_count, activated_at, enabled, is_active, identity_url'
  end

end


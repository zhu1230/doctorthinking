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


class BlogPostsController < ApplicationController

  # uses_tiny_mce :options => {
  #                             :theme => 'advanced',
  #                             :theme_advanced_toolbar_location => "top",
  #                             :theme_advanced_toolbar_align => "left",
  #                             :theme_advanced_resizing => true,
  #                             :theme_advanced_resize_horizontal => false,
  #                             :theme_advanced_buttons1 => "forecolor,backcolor,bullist,numlist,separator,outdent,indent,separator,undo,redo,separator,link,unlink,anchor,image,cleanup,help,code",
  #                             :theme_advanced_buttons2 => "",
  #                             :theme_advanced_buttons3 => ""
  #                           }
    # uses_tiny_mce :options => {
    # 						    :theme => 'advanced',  # 皮肤  
    # 						    :language => 'zh',  # 中文界面  
    # 						    :convert_urls => false, # 不转换路径，否则在插入图片或头像时，会转成相对路径，容易导致路径错乱。  
    # 						    :theme_advanced_toolbar_location => "top",  # 工具条在上面  
    # 						    :theme_advanced_toolbar_align => "left",  
    # 						    :theme_advanced_resizing => true,  # 似乎不好使  
    # 						    :theme_advanced_resize_horizontal => false,  
    # 						    :paste_auto_cleanup_on_paste => true,
    # 						    # 工具条上的按钮布局  
    # 						    :theme_advanced_buttons1 => %w{formatselect fontselect fontsizeselect forecolor backcolor bold italic underline strikethrough sub sup removeformat},  
    # 						    :theme_advanced_buttons2 => %w{undo redo cut copy paste separator justifyleft justifycenter justifyright separator indent outdent separator bullist numlist separator link unlink image media emotions separator table separator fullscreen},  
    # 						    :theme_advanced_buttons3 => [],  
    # 						    # 字体列表中显示的字体  
    # 						    :theme_advanced_fonts => %w{宋体=宋体;黑体=黑体;仿宋=仿宋;楷体=楷体;隶书=隶书;幼圆=幼圆;Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Trebuchet MS=trebuchet ms,geneva;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats}, # 字体  
    # 						    # :force_br_newlines => true, # 此选项强制编辑器将段落符号(P)替换成换行符(BR)。不建议用：ff下不好使，用了此选项后，输入内容的居中、清单或编号都被破坏。  
    # 						    :plugins => %w{contextmenu paste media emotions table fullscreen}},
    # 						  :only => [:new, :edit, :show, :index, :create, :update,:add_comment]# tiny_mce考虑的非常贴心，这里是限定哪些action中起用
 require_role "user", :only => [:new, :edit, :create, :update,:add_comment]
  
  # only event creator or an admin can edit or update an event.
  before_filter :check_auth, :only => [:edit, :update]
  
  
  def check_auth
    blog_post = BlogPost.find(params[:id])
    if current_user != blog_post.user && !current_user.is_admin
      access_denied
    end 
  end


  def get_all_topics
    @blog_post_topics = current_user.blog_post_topics
  end

  
  # This action should be called from a CRON job to update any external blogs
  def update_external_blogs
    users = User.find(:all, :conditions=>'blog_feed is not null')
    users.each do |user| 
      if user.blog_feed.length > 0
        BlogPost.update_from_feed(user.blog_feed, user.id)
      end
    end
  end
  
  
  # This method is called via AJAX to add a comment to a blog post

  
  
  # List all the blog posts
  def index
    if params[:user_id]
      index_blog_posts_for_user
    elsif params[:topic_id]
        @blog_post_topic = BlogPostTopic.find(params[:topic_id])
        @blog_posts = @blog_post_topic.blog_posts.paginate(:all, :page=>params[:page])
        @blog_post_count = @blog_posts.length
    elsif params[:month]
      month = params[:month].to_i
      # show blog posts from the specified month and year
      date = "#{month}/01/#{params[:year]}".to_date
      start_date = "#{date.year.to_s}-#{date.strftime('%m')}-01"
      end_date = "#{date.year.to_s}-#{(date + 1.month).strftime('%m')}-01"
      
      @blog_posts = BlogPost.paginate(:all, :page => params[:page],
                                      :conditions => "created_at > '#{start_date}' AND created_at < '#{end_date}'", 
                                      :page => params[:page], :order => 'created_at DESC') 
      @blog_post_count = BlogPost.count(:conditions => "published = 'true' AND created_at > '#{start_date}' AND created_at < '#{end_date}'")
    else
        # show paginated view of all blog posts
        @blog_posts = BlogPost.paginate(:all, :page => params[:page], :order => 'created_at DESC') 
        @blog_post_count = BlogPost.published_count
    end
    respond_to do |format|
      format.html { render :template=>'blog_posts/blog_posts_list' } 
      format.xml  { render :xml => @blog_posts }
      format.json { render :json => @blog_posts.to_json } 
    end
  end
  
  
  # List the blog posts for a specific user
  def index_blog_posts_for_user
    @user = User.find(params[:user_id])
    @blog_posts = @user.blog_posts.paginate(:all, :page => params[:page], :order => 'created_at DESC')
    @blog_post_count = @user.blog_posts.length
    draft = BlogPost.find(:first, :conditions=>'published=0')
    if draft
      @drafts_exist = true
    else
      @drafts_exist = false
    end
  end


  def show
    @blog_post = BlogPost.find(params[:id])
    @blog_post.update_attribute('views', @blog_post.views+1)
    respond_to do |format|
      format.html {render :template => 'blog_posts/blog_posts_show' }
      format.xml  { render :xml => @blog_post }
      format.json { render :json => @blog_post.to_json } 
    end
  end


  def new
    @blog_post = BlogPost.new
    get_all_topics
    render :partial=>'blog_posts_edit', :layout=>true
  end


  def edit
    @blog_post = BlogPost.find(params[:id])
    get_all_topics
    render :partial=>'blog_posts_edit', :layout=>true
  end


  def create
    @blog_post = BlogPost.new(params[:blog_post])
    @blog_post.user = current_user;
    get_all_topics
    respond_to do |format|
      if @blog_post.save
        @blog_post.update_blog_post_topics
        flash[:notice] = 'BlogPost was successfully created.'
        format.html { redirect_to(@blog_post) }
        format.xml  { render :xml => @blog_post, :status => :created, :location => @blog_post }
        format.json  { render :json => @blog_post.to_json, :status => :created, :location => @blog_post }
      else
        format.html { render :partial=>'blog_posts_edit', :layout=>true }
        format.xml  { render :xml => @blog_post.errors, :status => :unprocessable_entity }
        format.json  { render :json => @blog_post.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # Update the publish status to true of a blog post
  def publish
    @blog_post = BlogPost.find(params[:id])
    respond_to do |format|
      if @blog_post.publish
        format.html { redirect_to(@blog_post) }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { redirect_to(@blog_post) }
        format.xml  { render :xml => @blog_post.errors, :status => :unprocessable_entity }
        format.json  { render :json => @blog_post.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end

	def tagged
	  # @blog_posts = BlogPost.paginate(:all, :page => params[:page], :order => 'created_at DESC') 
	  #       @blog_post_count = BlogPost.count(:conditions => "published = true")
@blog_posts = BlogPost.tagged_with(Tag.find(params[:tag]).name,:on => :tags).by_date.paginate(:page => params[:page], :per_page => 20)
@blog_post_count=BlogPost.tagged_with(Tag.find(params[:tag]).name,:on => :tags).published.size
    respond_to do |format|
      format.html { render :template=>'blog_posts/blog_posts_list' } 
      format.xml  { render :xml => @blog_posts }
      format.json { render :json => @blog_posts.to_json } 
    end
	end
	
	
  def update
    @blog_post = BlogPost.find(params[:id])
    get_all_topics
    respond_to do |format|
      if @blog_post.update_attributes(params[:blog_post])
        @blog_post.update_blog_post_topics
        flash[:notice] = 'BlogPost was successfully updated.'
        format.html { redirect_to(@blog_post) }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog_post.errors, :status => :unprocessable_entity }
        format.json  { render :json => @blog_post.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    respond_to do |format|
      format.html { redirect_to(blog_posts_url) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
end

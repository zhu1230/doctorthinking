class BlogPostTopicsController < ApplicationController


  def index
    @blog_post_topics = BlogPostTopic.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blog_post_topics }
    end
  end
  
  
  def ajax_save
    topic = params[:blog_post_topic]
    BlogPostTopic.create(:name => topic, :user_id => current_user.id)
    @blog_post_topics = BlogPostTopic.find(:all)
    render :text => ''
  end
  
  
  def fetch_topic_list
    @blog_post = BlogPost.find(params[:blog_post_id])
    @blog_post_topics = BlogPostTopic.find(:all)
    render :partial=>'/blog_posts/blog_post_topic_list', :layout=>false
  end


  def show
    @blog_post_topic = BlogPostTopic.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blog_post_topic }
    end
  end


  def new
    @blog_post_topic = BlogPostTopic.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog_post_topic }
    end
  end


  def edit
    @blog_post_topic = BlogPostTopic.find(params[:id])
  end


  def create
    @blog_post_topic = BlogPostTopic.new(params[:blog_post_topic])
    respond_to do |format|
      if @blog_post_topic.save
        flash[:notice] = 'BlogPostTopic was successfully created.'
        format.html { redirect_to(@blog_post_topic) }
        format.xml  { render :xml => @blog_post_topic, :status => :created, :location => @blog_post_topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @blog_post_topic.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @blog_post_topic = BlogPostTopic.find(params[:id])
    respond_to do |format|
      if @blog_post_topic.update_attributes(params[:blog_post_topic])
        flash[:notice] = 'BlogPostTopic was successfully updated.'
        format.html { redirect_to(@blog_post_topic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog_post_topic.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @blog_post_topic = BlogPostTopic.find(params[:id])
    @blog_post_topic.destroy
    respond_to do |format|
      format.html { redirect_to(blog_post_topics_url) }
      format.xml  { head :ok }
    end
  end
  
  
end

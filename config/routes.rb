ActionController::Routing::Routes.draw do |map|
  map.resources :flags

  map.resources :wysihat_files


  map.resources :blog_post_topics

  map.resources :nav_items
  map.resources :ey_modules
  map.resources :modules
  
  # Jammit::Routes.draw(map)


  map.resources :follows
  map.resources :contents
  map.resources :facebook_posts
  map.resources :ideas
  
  map.resources :classifieds
  map.resources :projects
  map.resources :links
  map.resources :bug_reports
  map.resources :forum_topics
  map.resources :announcements
  map.resources :job_posts
  map.resources :book_reviews
  map.resources :replies
  map.resources :rss_feeds
  map.resources :networks
  map.resource :api_key

  map.resources :widget_layouts, :collection => {:load => :get}
  map.resources :widgets, :collection => {:grid_data=>:get, :load=>:get}
  map.resources :forum_posts, :collection => {:grid_data=>:get}
  map.resources :blog_posts, :collection => {:publish=>:get}
  map.resources :events, :collection => {:full_index=>:get,:participate=>:get}
  map.resources :stats, :collection => {:index=>:get}
  map.resources :memberships, :collection => {:find=>:get}
  
  map.resources :photo_albums
  map.resources :status_posts
  map.resources :html_contents
  map.resources :html_contents
  map.resources :feeds
  map.resources :widgets
  map.resources :forum_posts
  map.resources :wall_posts
  map.resources :events
  map.resources :activities

  map.connect 'memberships/find', :controller=>'memberships', :action=>'find' 
  map.connect 'users/change_photo', :controller=>'users', :action=>'change_photo'
  map.connect 'groups/user_data', :controller=>'groups', :action=>'user_data'
  map.connect 'users/promote_to_group_admin', :controller=>'users', :action=>'promote_to_group_admin'
  map.connect 'wall_posts/delete', :controller=>'wall_posts', :action=>'destroy'
  map.connect 'users/authenticate.:format', :controller=>'users', :action=>'authenticate'
  map.connect 'blog_post_topics/ajax_save', :controller=>'blog_post_topics', :action=>'ajax_save'
  map.connect 'blog_post_topics/fetch_topic_list', :controller=>'blog_post_topics', :action=>'fetch_topic_list'
  map.connect 'likes/like_text', :controller=>'likes', :action=>'like_text'
  
  map.resources :blog_post_topics
  map.resources :videos
  map.resources :blogs

  map.resources :blog_posts  do |bp|
	bp.resources :comments,:controller=>"blog_posts",:collection => {:add_comment => :post}
	end

  map.resources :groups
  map.resources :photos
  map.resources :profile_photos
  map.resources :messages
  map.resources :memberships
  map.resource :session
  map.resources :likes
  
  
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.forgot    '/forgot', :controller => 'users', :action => 'forgot'  
  map.reset     '/reset/:reset_code', :controller => 'users', :action => 'reset'
  map.resources :users, :collection => {:search => :get,:online_users=>:get, :grid_data=>:get, :link_facebook_account => :get},:member => { :follow => :post,:unfollow => :post}

  map.resource :session
  
  map.resources :users do |user|
	user.resources :favorite_bingli_infos,:as => :bingli_info,:only => [:index]
    user.resources :activities
    user.resources :friends
    # user.resources :follows
    user.resources :announcements
    user.resources :book_reviews
    user.resources :groups,:collection => {:participate=>:get}
    user.resources :events,:collection => {:participate=>:get}
    user.resources :photos
    user.resources :messages
    user.resources :bug_reports
    user.resources :blog_posts
    user.resources :forum_posts
    user.resources :wall_posts
    user.resources :photos
    user.resources :photo_albums
    user.resources :links
    user.resources :projects
    user.resources :classifieds
	user.resources :invites,:collection => {:send_contacts => :post}
  end 
  map.resources :invites
  map.resources :groups do |group|
    group.resources :wall_posts
    group.resources :users
    group.resources :announcements
  end 
  
  map.resources :events do |event|
    event.resources :users
    event.resources :wall_posts
  end
  
  map.resources :forum_topics do |forum_topic|
    forum_topic.resources :forum_posts
  end
  
  # admin
  map.namespace :admin do |a|
    a.resource :theme
    a.resources :domain_themes
  end
  
  map.connect 'pages/show/:name', :controller => 'pages', :action => 'show'
  
  map.resources :pages

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"
 map.namespace :biz do |biz|
 	biz.resources :bingli_infos,:member => {:favorite => :get,:voteup => :get,:votedown => :get},:collection => {:hot => :get,:active => :get,:week => :get,:month => :get,:search => :get,:query => :post,:autocomplete => :get} do |bi|
 		bi.resources :comments, :shallow => true
		bi.resources :bingli_comments
 		# bi.resources :tags
 	end
	biz.resources :bingli_comments ,:member => {:voteup => :get,:votedown => :get} do |bc|
		bc.resources :comments
		bc.resources :tags
	end
 end
 map.resources :comments, :controller => "biz/comments"
 map.with_options :controller => 'pages' do |page|
 	page.about 'about_us',:action => 'about_us'
	page.privacy 'privacy',:action => 'privacy'
	page.terms 'terms',:action => 'terms'
	
 end
map.resources :tags ,:collection => {:bingli_infos => :get,:bingli_comments => :get,:search => :post}do |t|
	t.resources :bingli_infos
	t.resources :bingli_comments
end
 # map.connect ':controller/:action/:id'
	# map.resources :bingli_infos 
	# map.resources :bingli_comments 
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.tagged_source ':controller/tagged/:tag',:action=>'tagged'
  # map.connect 'biz/bingli_comment/:action/:id',:controller=>'biz/bingli_comment'
  map.index '/',:controller=>"home",:action=>"index"
  # map.about_us :controller=>"about"
# map.connect '/biz/blingli_info/active',:controller=>"biz/bingli_info",:action=>"active"
  # map.connect 'biz/bingli_info/:action/:id',:controller=>"biz/bingli_info"
  # map.connect 'biz/bingli_info/:action/:id',:controller=>"biz/bingli_info"
  #for tag
  # map.privacy '/privacy',:controller => ''
  #map.connect ':controller/:action/:type/:id'
  #for fine,perfect,favorite,participation
  map.connect 'user/:action/:id',:controller=>"user"
  map.connect 'meet/:action/:id',:controller=>"meet"
  # map.connect 'biz/bingli_info/:action/:keshi',:controller=>"biz/bingli_info"
  
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

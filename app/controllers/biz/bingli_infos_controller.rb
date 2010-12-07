class Biz::BingliInfosController < ApplicationController
	in_place_edit_for :comment,:comment
	# in_place_edit_for :user,:about_me,{:error_messages=>"error"}
  require_role "user",:only=>[:new,:create,:add_favorite]
	after_filter :increment_page_views, :only => [:show]
	include PageViews::Controller
  def index
    #params[:keshi]=1 unless params[:keshi]
    @bingli_infos=BingliInfo.paginate :page=>params[:page],:order=>'created_at desc'#,:conditions=>["keshi_id= ?",params[:keshi]]
    #@bingli_infos=BingliInfo.find(:all,:conditions=>["keshi_id= ?",params[:keshi]])
  end
	def hot
		@bingli_infos=BingliInfo.paginate :page=>params[:page],:order => :page_views_counter
		render :action => "index"
	end
	def active
		@bingli_infos=BingliInfo.tally(
	  {  :at_least => 1, 
	      :at_most => 10000,  
	      :start_at => 10.weeks.ago,
	      :end_at => 1.day.ago,
	      :order => 'votes.count desc',
		  :conditions=>["votes.voteable_type=:voteable_type",{:voteable_type => 'BingliInfo'}]
	  }).paginate :page=>params[:page]
	render :action => "index"
	end
	def week
		@bingli_infos=BingliInfo.paginate :page=>params[:page],:conditions => ['created_at > ?',1.weeks.ago],:order =>'created_at desc'
		render :action => "index"
	end
	def month
	@bingli_infos=BingliInfo.paginate :page=>params[:page],:conditions => ['created_at > ?',1.months.ago],:order =>'created_at desc'
	render :action => "index"
	end


  def show
    @bingli_info=BingliInfo.find(params[:id],:include=>[:bingli,:user])
    @bingli=@bingli_info.bingli
	if params[:type]=='old'
			@bingli_comments=BingliComment.paginate :conditions=>["bingli_info_id =:bingli_info_id",{:bingli_info_id=>params[:id]}],:order => 'created_at asc',:page=>params[:page]
    # @bingli_comments=BingliComment.tally({:at_least=>1,:at_most => 10000,:order => "voteable.created_at desc",:conditions=>["bingli_info_id =:bingli_info_id and votes.voteable_type=:voteable",{:bingli_info_id=>params[:id],:voteable => 'BingliComment'}]}).paginate :per_page=>20,:page=>params[:page]
	elsif params[:type]=='new'
	@bingli_comments=BingliComment.paginate :conditions=>["bingli_info_id =:bingli_info_id",{:bingli_info_id=>params[:id]}],:order => 'created_at desc',:page=>params[:page]
	else
  	@bingli_comments=BingliComment.find(:all,:select => '*,(vote_for_count - vote_against_count) as count',:conditions => ["bingli_info_id=:id",{:id => params[:id]}],:order => 'count desc,id asc').paginate :page=>params[:page]
	end
		
    @user=@bingli_info.user
  end
def edit
	@bingli_info=BingliInfo.find(params[:id])
	render :action => :new
end
def update
	@bingli_info=BingliInfo.update(params[:id],params[:bingli_info])
	if !@bingli_info.errors.blank?
		render :action => :new
	else
	# @bingli=@bingli_info.bingli
	#    	@bingli_comments=BingliComment.find(:all,:select => '*,(vote_for_count - vote_against_count) as count',:conditions => ["bingli_info_id=:id",{:id => params[:id]}],:order => 'count desc,id asc').paginate :page=>params[:page]
	#     @user=@bingli_info.user
	flash[:success]="病例修改成功！"
	redirect_to biz_bingli_info_url(@bingli_info)
	end
end


  def new
@bingli_info=BingliInfo.new
  end
  # def add_favorite
  #   current_user.favorites << BingliInfo.find(params[:id])
  #  # current_user.save
  # end
  def create
        @bingli_info=BingliInfo.new(params[:bingli_info])
		@bingli_info.user=current_user
		@bingli_info.created_at=Time.new
		
        # process_yiwen params,@bingli
        # process_chubu params,@bingli
        # process_fuzhu params,@bingli unless params[:fuzhu].blank?
# params[:bingli_info][:catelog_id]=0
#         @bingli.bingli_info=BingliInfo.new(params[:bingli_info])
#         @bingli.bingli_info.user=current_user
#         @bingli.bingli_info.created_at=Time.new
        # process_bingli_info params,@bingli
        if  @bingli_info.save  
		flash[:success]="病例发布成功！"
          redirect_to biz_bingli_info_url(@bingli_info)
        else
         render :action=>"new"
        end
  end
	def tagged
		@bingli_infos=BingliInfo.tagged_with(params[:tag],:on => :tags).paginate(:page => params[:page])
	end
	def search
		
	end
	def query
		if params[:query_type]=='simple'
			@bingli_infos=BingliInfo.search(params[:search])
		elsif params[:query_type]=='advanced'
			conditions=''
			if params[:bingli_info]
				conditions=''
				params[:bingli_info].each_value do |v|
					next if v['condition_type'].blank?
					p ">>>"+conditions
					if v['item']=='fuzhu_detail'
						conditions << and_or_except(v['fuzhus'],v['condition_type'],v['content'])
					else
						conditions << and_or_except(v['item'],v['condition_type'],v['content'])
					end
				end
			end
			p ">>>"+conditions
			@binglis = Bingli.search( conditions,:include => [:bingli_info],:match_mode =>:extended) 
		end
		
	end
	
  private
def and_or_except(field,cond,value)
	if cond=='or'
		"@#{field} #{value} " 
	elsif cond=='and'
		"@#{field} #{value} "
	elsif cond=='except'
		"@#{field} -#{value} "
	end
end

def increment_page_views
  page_views_increment @bingli_info  #load @post before
end
  # def process_fuzhu(params,bingli)
  #      params[:fuzhu].each {|fu|
  #         f=fu[1]
  #         f['file'].delete_if{|temp|temp.blank?} if !f['file'].nil?
  #         if(f.blank? or f['fuzhu_type'].blank? or (f['content'].blank? and f['file'].nil?))then next end
  #           fuzhu=FuzhuDetail.new(:fuzhu_type_id=>f['fuzhu_type'],:content=>f['content'])
  #           f['file'].each{|file|
  #           if(file.blank?)then next end
  #           pic=Attachment.new({'uploaded_data'=>file})
  #           fuzhu.attachments << pic
  #           }
  #           bingli.fuzhu_details << fuzhu
  #         }
  #   end
  #   def process_chubu(params,bingli)
  #         params[:chubu].each {|c|
  #         if c.blank? then next end
  #         bingli.chubu_has=1
  #         bingli.chubu_details << ChubuDetail.new(:content=>c)
  #         }
  #   end
  #   def process_yiwen(params,bingli)
  #         params[:yiwen].each {|q|
  #         if(q.blank?)then next end
  #         bingli.yiwen_has=1
  #         bingli.question_details << QuestionDetail.new(:content=>q)
  #         }
  #   end
  #   def process_bingli_info(params,bingli)
  #         bingli.bingli_info.tags << Tag.find(params[:tags]['already']) unless params[:tags]['already'].blank?
  #         params[:tags]['custom'].split(/,|，/).each{|t|
  #         t.strip!
  #         tag=Tag.exists?(:name=>t)?Tag.find(:first,:conditions=>["name=:title",{:title=>t}]):Tag.create(:name=>t)
  #         bingli.bingli_info.tags << tag unless bingli.bingli_info.tags.include? tag
  # 
  #         }
  #         
  #   end
end

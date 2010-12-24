class MeetingsController < ApplicationController
	require_role :user,:only=>[:new,:create,:fileupload]
	after_filter :increment_page_views, :only => [:show]
	# before_filter :set_keshi
	include PageViews::Controller
  def index
	 @month = (params[:month] || Time.zone.now.month).to_i
	      @year = (params[:year] || Time.zone.now.year).to_i

	      @shown_month = Date.civil(@year, @month)

	      # @event_strips = Meeting.event_strips_for_month(@shown_month)
	
    @meetings=(params[:keshi] ? Keshi.find(params[:keshi]).meetings : Meeting.all).paginate :page=>params[:page],:per_page => 10
  @event_strips = Meeting.event_strips_for_month @shown_month,
:conditions => (['keshi_id=?',params[:keshi]] if params[:keshi] )

  end
  def show
    @meeting=Meeting.find(params[:id])
    @comments=Comment.paginate(:conditions => ["commentable_type = ? and commentable_id = ?","Meeting",@meeting.id],
    :order => "created_at DESC",:per_page=>10,:page=>params[:page],:include=>"user")
  end
  def new
	@meeting=Meeting.new
  end
  
  def create
    m=Meeting.new(params[:meeting])
	m.state=params['meeting_state']
	m.country=params['meeting_country']
    # m.tag_list = params[:meeting]['tag_list'].split(/,|，/).join ','
    # m.arrange_time=[params['meeting']['arrange_time(1i)'],params['meeting']['arrange_time(2i)'],params['meeting']['arrange_time(3i)']].join('-')
    # logger.info [params['meeting']['arrange_time(1i)'],params['meeting']['arrange_time(2i)'],params['meeting']['arrange_time(3i)']].join('-')
    # m.address=[params[:country],params[:state],params[:city]].join "-"
    m.meeting_attaches << MeetingAttach.find(params[:attach]) unless params[:attach].blank?
    m.user=current_user
    m.save!
    flash[:notice] = "会议保存成功..."
    redirect_to meeting_path(m)
  end
  def fileupload
    am=MeetingAttach.new :file=>params[:Filedata]
	am.user=current_user
	mime_type = MIME::Types.type_for(am.file_file_name)    
	am.file_content_type = mime_type.first.content_type.to_s if mime_type.first
    am.save!
    render :text=>"FILEID:"+am.id.to_s
  end
def tagged
	 @month = (params[:month] || Time.zone.now.month).to_i
	      @year = (params[:year] || Time.zone.now.year).to_i

	      @shown_month = Date.civil(@year, @month)
	
end

	private
	def increment_page_views
	  page_views_increment @meeting  #load @post before
	end
end

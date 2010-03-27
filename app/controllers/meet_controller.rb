class MeetController < ApplicationController
require_role :user,:only=>[:input,:save,:fileupload]
  def index
    @meetings=Meeting.paginate :page=>params[:page],:order=>"thetime",:per_page => 5
  end
  def showone
    
    @meeting=Meeting.find(params[:id])
    @comments=Comment.paginate(:conditions => ["commentable_type = ? and commentable_id = ?","Meeting",@meeting.id],
    :order => "created_at DESC",:per_page=>10,:page=>params[:page])
  end
  def input
  end
  
  def save
    m=Meeting.new(params[:meeting])
    m.tag_list = params[:tags]['custom'].split(/,|，/).join ','
    m.arrange_time=[params['meeting']['arrange_time(1i)'],params['meeting']['arrange_time(2i)'],params['meeting']['arrange_time(3i)']].join('-')
    logger.info [params['meeting']['arrange_time(1i)'],params['meeting']['arrange_time(2i)'],params['meeting']['arrange_time(3i)']].join('-')
    m.address=[params[:country],params[:state],params[:city]].join "-"
    m.attachment_miscs << AttachmentMisc.find(params[:attach])
    m.thetime=Time.now
    m.user=current_user
    m.save!
    flash[:notice] = "会议保存成功..."
    redirect_to :controller=>'meet',:action=>'showone',:id=>m.id
  end
  def fileupload
    am=AttachmentMisc.new :uploaded_data=>params[:Filedata]
    am.save!
    render :text=>"FILEID:"+am.id.to_s
  end
end

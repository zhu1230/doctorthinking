class Biz::BingliCommentController < ApplicationController
  require_role "user",:only=>:save
  require_role "user",:only=>:input
  require_role "user",:only=>:add_bingli_comment
  def input
    
  end

  def save
    bingli_comment=BingliComment.new(params[:bingli_comment])
    bingli_comment.user=current_user
    bingli_info=BingliInfo.find(params[:bingli_info_id])
    bingli_comment.catelog=bingli_info.catelog
    bingli_comment.keshi=bingli_info.keshi
    bingli_comment.bingli_info=bingli_info
    bingli_comment.thetime=Time.new
    bingli_comment.save
	flash[:notice]="回复成功"
    redirect_to :controller=>"biz/bingli_info",:action=>"showOne",:id=>params[:bingli_info_id]
  end
  def show
    @bingli_comment=BingliComment.find(params[:id])
  end
  def add_bingli_comment
     c=Comment.new
    c.comment=params[:comment]
    c.user_id=current_user.id
    p=BingliComment.find(params[:bingli_comment_id])
    p.comments << c
    p.save
    redirect_to :back
  end
end

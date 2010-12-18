class Biz::BingliCommentsController < ApplicationController
  require_role "user",:only=>[:save,:update,:edit,:input,:create,:new]

  def input
    
  end

	#   def create
	#     bingli_comment=BingliComment.new(params[:bingli_comment])
	#     bingli_comment.user=current_user
	#     bingli_info=BingliInfo.find(params[:bingli_info_id])
	#     # bingli_comment.catelog=bingli_info.catelog
	#     bingli_comment.keshi=bingli_info.keshi
	#     bingli_comment.bingli_info=bingli_info
	#     bingli_comment.thetime=Time.new
	#     bingli_comment.save
	# flash[:notice]="回复成功"
	#     redirect_to :controller=>"biz/bingli_info",:action=>"show",:id=>params[:bingli_info_id]
	#   end
  def show
    @bingli_comment=BingliComment.find(params[:id])
	locate_bingli_comment(@bingli_comment)
  end
  # def add_bingli_comment
  #    c=Comment.new
  #   c.comment=params[:comment]
  #   c.user_id=current_user.id
  #   p=BingliComment.find(params[:bingli_comment_id])
  #   p.comments << c
  #   p.save
  #   redirect_to :back
  # end
	def update
		@bingli_comment=current_user.bingli_comments.update(params[:id],params[:bingli_comment])
		if @bingli_comment.errors.blank?
			flash[:success]='讨论编辑成功！'
			locate_bingli_comment(@bingli_comment)
		else
			render :action => 'new'
		end
	end
	def new
		@bingli_comment=BingliInfo.find(params[:bingli_info_id]).bingli_comments.new
		# render :action => :edit
	end
	def edit
		@bingli_comment=current_user.bingli_comments.find(params[:id],:include => [:bingli_info])	
	end
	def create
		# if (bc=current_user.bingli_comments.recent.limit(1).first).updated_at > 30.seconds.ago
		# 	flash.now[:warning]="30秒内仅能发表一个讨论，请稍后重试。"
		# 	render :action => :new 
		# 	 return
		# end
		@bingli_comment=BingliComment.new(params[:bingli_comment])
		@bingli_comment.bingli_info=BingliInfo.find(params[:bingli_info_id])
		@bingli_comment.user=current_user
		bc=current_user.bingli_comments.recent.limit(1).first
		if !bc.nil? && bc.updated_at > 30.seconds.ago
			flash.now[:warning]="30秒内仅能发表一个讨论，请稍后重试。"
			render :action => :new and return
		end
		if(@bingli_comment.save)
			flash[:success]='讨论发表成功！'
			 locate_bingli_comment(@bingli_comment)
		else
			# @bingli_info=@bingli_comment.bingli_info
			render :action => :new
		end
	end
	private
	def locate_bingli_comment(bingli_comment)
		count=BingliComment.count(:conditions=>["bingli_info_id=:id and ((vote_for_count - vote_against_count) > :count or ((vote_for_count - vote_against_count) = :count and  id < :bid))",{:id => bingli_comment.bingli_info.id,:count => bingli_comment.votes_value,:bid => bingli_comment.id}])
		page=(count / BingliComment.per_page)+1
		redirect_to biz_bingli_info_url(bingli_comment.bingli_info,:page => page,:anchor => bingli_comment.id),:flash =>{:highlight =>"bingli_comment_#{bingli_comment.id}" } 
	
	end
	
	
	
	
	
end

class Biz::BingliCommentsController < ApplicationController
	# uses_tiny_mce :options => {
	# 					    :theme => 'advanced',  # 皮肤  
	# 					    :language => 'zh',  # 中文界面  
	# 					    :convert_urls => false, # 不转换路径，否则在插入图片或头像时，会转成相对路径，容易导致路径错乱。  
	# 					    :theme_advanced_toolbar_location => "top",  # 工具条在上面  
	# 					    :theme_advanced_toolbar_align => "left",  
	# 					    :theme_advanced_resizing => true,  # 似乎不好使  
	# 					    :theme_advanced_resize_horizontal => false,  
	# 					    :paste_auto_cleanup_on_paste => true,
	# 					    # 工具条上的按钮布局  
	# 					    :theme_advanced_buttons1 => %w{formatselect fontselect fontsizeselect forecolor backcolor bold italic underline strikethrough sub sup removeformat},  
	# 					    :theme_advanced_buttons2 => %w{undo redo cut copy paste separator justifyleft justifycenter justifyright separator indent outdent separator bullist numlist separator link unlink image media emotions separator table separator fullscreen},  
	# 					    :theme_advanced_buttons3 => [],  
	# 					    # 字体列表中显示的字体  
	# 					    :theme_advanced_fonts => %w{宋体=宋体;黑体=黑体;仿宋=仿宋;楷体=楷体;隶书=隶书;幼圆=幼圆;Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Trebuchet MS=trebuchet ms,geneva;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats}, # 字体  
	# 					    # :force_br_newlines => true, # 此选项强制编辑器将段落符号(P)替换成换行符(BR)。不建议用：ff下不好使，用了此选项后，输入内容的居中、清单或编号都被破坏。  
	# 					    :plugins => %w{contextmenu paste media emotions table fullscreen}},
	# 					  :only => [:input]# tiny_mce考虑的非常贴心，这里是限定哪些action中起用
						
  require_role "user",:only=>[:save,:update,:edit,:input,:create]

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
		@bingli_comment=BingliComment.update(params[:id],params[:bingli_comment])
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
		@bingli_comment=BingliComment.find(params[:id],:include => [:bingli_info])	
	end
	def create
		@bingli_comment=BingliComment.new(params[:bingli_comment])
		@bingli_comment.bingli_info=BingliInfo.find(params[:bingli_info_id])
		@bingli_comment.user=current_user
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
		count=BingliComment.count(:conditions=>["bingli_info_id=:id and ((vote_for_count - vote_against_count) > :count or ((vote_for_count - vote_against_count) = :count and  id < :bid))",{:id => bingli_comment.bingli_info.id,:count => bingli_comment.vote_value,:bid => bingli_comment.id}])
		page=(count / BingliComment.per_page)+1
		redirect_to biz_bingli_info_url(bingli_comment.bingli_info,:page => page,:anchor => bingli_comment.id)
	end
	
	
	
	
	
end

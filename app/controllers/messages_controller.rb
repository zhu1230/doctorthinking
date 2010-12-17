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

class MessagesController < ApplicationController

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
	# 					  :only => [:new, :edit, :show, :index, :create, :update]# tiny_mce考虑的非常贴心，这里是限定哪些action中起用
                            
 require_role "user"
  
                            
  def index
    
    @sent_messages = current_user.sent_messages
    @received_messages = current_user.received_messages
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
      format.json { render :json => @messages } 
    end
  end


  def show
    @message = Message.find(params[:id])
    if current_user == @message.recipient
      @message.update_attributes(:read=>true)
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
      format.json { render :json => @message } 
    end
  end


  def new
	
    @message = Message.new
    @recipient_id = params[:user_id] unless params[:user_id].to_i==current_user.id
    @subject = params[:subject]
    if @recipient_id == nil
      @users = current_user.following_by_type('User',:limit => 50)#find(:all, :conditions => "activated_at is not null")
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
      format.json { render :json => @message } 
    end
  end


  def create
    @message = Message.new(params[:message])
    @message.sender_id = current_user.id
    respond_to do |format|
      if @message.save
        flash[:notice] = '消息已经成功发送.'
        # TODO send email notification to recipient
        
        format.html { redirect_to(@message) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
        format.json { render :json => @message, :status => :created, :location => @message } 
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
        format.json { render :json => @message.errors, :status => :unprocessable_entity } 
      end
    end
  end


  def update
    @message = Message.find(params[:id])
    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(@message) }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
        format.json { render :json => @message.errors, :status => :unprocessable_entity } 
      end
    end
  end


  def destroy
	Message.destroy(params[:id])
    # @message = Message.find(params[:id])
    # @message.destroy
	flash[:notice]='消息已成功删除。'
    respond_to do |format|
      format.html { redirect_to(user_messages_url(current_user)) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
end

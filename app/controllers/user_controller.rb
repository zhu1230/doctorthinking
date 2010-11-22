class UserController < ApplicationController
require_role [:user,:admin]
in_place_edit_for :user,:name,{:error_messages=>"error"}
in_place_edit_for :user,:email,{:error_messages=>"error"}
in_place_edit_for :user,:keshiinplace,{:error_messages=>"error"}
# in_place_edit_for :user,:zhicheng_title,{:error_messages=>"error"}
in_place_edit_for :user,:about_me,{:error_messages=>"error"}
in_place_edit_for :user,:receive,{:error_messages=>"error"}
  def index
    
  end
  def update_avatar
	current_user.avatar=params[:avatar]
	if current_user.save
	flash[:success]="头像设置成功！"
	redirect_to :action=>"account"
	else
		redirect_to :action=>"account"
	end
end
  def account
    @user=current_user
  end
def pass_change
	
end
def capture(&block)
block.call
end

end


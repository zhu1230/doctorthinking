class UserController < ApplicationController
require_role :user
in_place_edit_for :user,:name,{:error_messages=>"error"}
in_place_edit_for :user,:email,{:error_messages=>"error"}
in_place_edit_for :user,:keshiinplace,{:error_messages=>"error"}
in_place_edit_for :user,:zhicheng_title,{:error_messages=>"error"}
in_place_edit_for :user,:about_me,{:error_messages=>"error"}
in_place_edit_for :user,:receive,{:error_messages=>"error"}
  def index
    
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


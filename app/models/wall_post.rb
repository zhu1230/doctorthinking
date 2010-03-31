class WallPost < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :group
  belongs_to :event
  belongs_to :sender, :class_name => 'User', :foreign_key =>'sender_id'
  
end

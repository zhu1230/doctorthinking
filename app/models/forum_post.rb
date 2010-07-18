class ForumPost < ActiveRecord::Base
  
  include Streamable 
  acts_as_streamable
    
  acts_as_taggable_on :tags
  
  belongs_to :user  
  belongs_to :forum_topic
  has_many :replies, :class_name => 'ForumPost', :foreign_key =>'parent_id'
  
  
  def short_form
    body[0..39] 
  end
  
  
end

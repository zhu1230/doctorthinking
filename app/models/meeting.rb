class Meeting < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable
has_event_calendar :start_at_field  => 'start_time', :end_at_field => 'end_time'
  belongs_to :user
  belongs_to :keshi
  has_many :meeting_attaches, :dependent => :destroy
with_page_views :buffer_size => 2, :days => 1, :model_name => 'meeting'
end

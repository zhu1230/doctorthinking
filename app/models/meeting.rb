class Meeting < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable
has_event_calendar :start_at_field  => 'start_time', :end_at_field => 'end_time'
  belongs_to :user
  belongs_to :keshi
  has_many :meeting_attaches, :dependent => :destroy
	validates_presence_of :title, :on => :create, :message => "不能为空"
	validates_format_of :start_time, :with => /^20[0-9]{2}[-][0-9]{2}[-][0-9]{2}$/, :message => '日期格式错误'
	validates_format_of :end_time, :with => /^20[0-9]{2}[-][0-9]{2}[-][0-9]{2}$/, :message => '日期格式错误'
	validates_presence_of :country, :on => :create, :message => "不能为空"
	validates_presence_of :state, :on => :create, :message => "不能为空"
	validates_presence_of :city, :on => :create, :message => "不能为空"
	validates_presence_of :zhuban, :on => :create, :message => "不能为空"
with_page_views :buffer_size => 2, :days => 1, :model_name => 'meeting'
end

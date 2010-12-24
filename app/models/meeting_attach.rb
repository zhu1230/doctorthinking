class MeetingAttach < ActiveRecord::Base
	has_attached_file :file,:styles => { :big => "600x600>",:medium => "258x174#", :thumb => "100x100>"},:path => ":rails_root/public/system/meeting/:id/:style/:filename",:url => "/system/meeting/:id/:style/:filename"
	validates_attachment_size :file,:less_than => 5.megabytes,:message => "文件大小不能超过5M。"
	validates_attachment_content_type :file,:content_type => ['image/gif','image/jpeg','image/pjpeg','image/png','image/x-png','image/tiff','image/bmp','application/rtf','text/plain','application/msword','application/doc','application/pdf'],:message => '头像只能使用类型为 jpg,gif,png,bmp,tiff 的图片。或者pdf,doc,txt,rtf文档。'
	before_post_process :is_image?
	belongs_to :user
	belongs_to :meeting
	def is_image?
		p file_content_type
	  !(file_content_type =~ /^image/).nil?
	end
end
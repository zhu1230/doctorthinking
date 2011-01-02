class SharedFile < ActiveRecord::Base
	has_attached_file :file,:styles => { :big => "600x600>",:medium => "258x174#", :thumb => "100x100>"},:path => ":rails_root/public/system/shared_file/:id/:style/:filename",:url => "/system/shared_file/:id/:style/:filename"
	validates_attachment_size :file,:less_than => 20.megabytes,:message => "文件大小不能超过20M。"
	validates_attachment_content_type :file,:content_type => ['image/gif','image/jpeg','image/pjpeg','image/png','image/x-png','image/tiff','image/bmp','application/rtf','text/plain','application/msword','application/doc','application/pdf','application/vnd.ms-powerpoint','application/ms-powerpoint'],:message => '文件的类型只是为 jpg,gif,png,bmp,tiff 的图片。或者ppt,pdf,doc,txt,rtf文档。'
	before_post_process :is_image?
	acts_as_commentable
  	acts_as_taggable
	belongs_to :user
	def is_image?
		p file_content_type
	  !(file_content_type =~ /^image/).nil?
	end
end

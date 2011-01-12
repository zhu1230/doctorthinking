class SharedResource < ActiveRecord::Base
	has_attached_file :zip_file,:path => ":rails_root/zip_files/:id/:filename",:url => ""
		validates_attachment_size :file,:less_than => 30.megabytes,:message => "文件大小不能超过30M。"
		validates_attachment_content_type :file,:content_type => ['application/x-zip-compressed','application/zip'],:message => '文件的类型只是为 zip'
		# before_post_process :is_image?
	acts_as_commentable
  	acts_as_taggable
include Pacecar
	belongs_to :user
	has_many :shared_files
	# has_one :zip_file
	# def is_image?
	# 	p file_content_type
	#   !(file_content_type =~ /^image/).nil?
	# end
end

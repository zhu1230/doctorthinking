class SharedResource < ActiveRecord::Base
	has_attached_file :zip_file,:path => ":rails_root/shared_file/zip_files/:id/:filename",:url => ""
		validates_attachment_size :zip_file,:less_than => 60.megabytes,:message => "文件大小不能超过60M。"
		# validates_attachment_content_type :zip_file,:content_type => ['application/x-zip-compressed','application/zip'],:message => '文件的类型只是为 zip'
		# before_post_process :is_image?
	acts_as_commentable
  	acts_as_taggable
include Pacecar
	belongs_to :user
	has_many :shared_files
	accepts_nested_attributes_for :shared_files, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
	# has_one :zip_file
	# def is_image?
	# 	p file_content_type
	#   !(file_content_type =~ /^image/).nil?
	# end
	with_page_views :buffer_size => 1, :days => 1, :model_name => 'shared_resource'
	def add_file(f)
		self.zip_file.assign File.new(f.path)
		mime_type = MIME::Types.type_for(self.zip_file_file_name)    
		self.zip_file_content_type = mime_type.first.content_type.to_s if mime_type.first
	end
end

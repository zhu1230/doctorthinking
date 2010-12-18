class Attachment < ActiveRecord::Base
	has_attached_file :file,:styles => {:big => {:processors => [:thumbnail,:watermark],:geometry =>'520x500>',:watermark_path => "#{Rails.public_path}/images/watermark.png",:position => 'SouthEast'},:thumb => '100x100#',:index => '100x70!'},:default_style => :big,:convert_options => {}
	validates_attachment_size :file,:less_than => 5.megabytes
	validates_attachment_content_type :file,:content_type => ['image/gif','image/jpeg','image/jpg','image/png','image/tiff'],:message => '附件只能使用类型为 jpg,gif,png,tiff 的图片。'
	belongs_to :fuzhu_detail
	
#      has_many :childs,
#              :class_name=>"Attachment",
#              :foreign_key => "parent_id"
# def random_tempfile_filename
# "#{rand Time.now.to_i}"
# end
attr_accessor :new_by_build
@new_by_build=false
def new_by_build?
	@new_by_build || false
end
def edit_file=(f)
	self.file.assign File.new(File.join(Rails.public_path,'tmp',f))
	mime_type = MIME::Types.type_for(self.file_file_name)    
	self.file_content_type = mime_type.first.content_type.to_s if mime_type.first
end

end

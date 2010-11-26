class Attachment < ActiveRecord::Base
	has_attached_file :file,:styles => {:big => '520x500>',:thumb => '100x100#',:index => '100x70!'},:default_style => :big,:convert_options => {}
	validates_attachment_size :file,:less_than => 5.megabytes
	validates_attachment_content_type :file,:content_type => ['image/gif','image/jpeg','image/png','image/tiff'],:message => '附件只能使用类型为 jpg,gif,png,tiff 的图片。'
	belongs_to :fuzhu_detail
	
#      has_many :childs,
#              :class_name=>"Attachment",
#              :foreign_key => "parent_id"
# def random_tempfile_filename
# "#{rand Time.now.to_i}"
# end
attr_accessor :new_by_build
@new_by_build=false;
def new_by_build?
	@new_by_build || false
end
def edit_file=(f)
	pp ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+f.inspect
	self.file.assign File.new(File.join(Rails.public_path,'tmp',f))
end

end

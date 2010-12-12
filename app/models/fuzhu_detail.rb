class FuzhuDetail < ActiveRecord::Base
	include Pacecar
  has_many :attachments
  belongs_to :fuzhu_type
  belongs_to :bingli
  attr_accessible :attachments_attributes,:fuzhu_type_id,:content
accepts_nested_attributes_for :attachments, :allow_destroy => true, :reject_if => proc { |obj| obj['file'].blank? && obj['edit_file'].blank? }
validates_associated :fuzhu_type, :on => :save, :message => "请选择检查类型"
validates_presence_of :fuzhu_type_id, :on => :save, :message => "请选择检查类型"
attr_accessor :new_by_build
@new_by_build=false;
	define_index do
		indexes :content
		has fuzhu_type(:id),:as => :fuzhu_type_id
		has bingli.bingli_info(:id),:as => :bingli_info_id
	end
def new_by_build?
	@new_by_build || false
end
end

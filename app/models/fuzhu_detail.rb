class FuzhuDetail < ActiveRecord::Base
  has_many :attachments
  belongs_to :fuzhu_type
accepts_nested_attributes_for :attachments, :allow_destroy => true, :reject_if => proc { |obj| obj['file'].blank? }
attr_accessor :new_by_build
@new_by_build=false;
def new_by_build?
	@new_by_build || false
end
end

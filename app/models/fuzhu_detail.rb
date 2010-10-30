class FuzhuDetail < ActiveRecord::Base
  has_many :attachments
  belongs_to :fuzhu_type
  has_many :fuzhu_pics
accepts_nested_attributes_for :attachments, :allow_destroy => true, :reject_if => proc { |obj| obj['uploaded_data'].blank? }

end

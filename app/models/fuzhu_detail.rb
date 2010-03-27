class FuzhuDetail < ActiveRecord::Base
  has_many :attachments
  belongs_to :fuzhu_type
  has_many :fuzhu_pics
end

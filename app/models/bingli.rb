class Bingli < ActiveRecord::Base
  acts_as_commentable
  has_one :bingli_info
  has_many :chubu_details#,:conditions=>"chubu_has is not null" 
  has_many :fuzhu_details#,:conditions=>"fuzhu_has is not null"
  has_many :question_details#,:conditions=>"yiwen_has is not null"
  has_many :attachments
  belongs_to :user
  validates_presence_of :bingli_info
  validates_presence_of :zhusu
  acts_as_ferret :fields => [:zhusu, :yibanqingkuang,:zhuyaozhengzhuang,:xianbingshi,:tigejiancha,:jiwang,:final]

#  validates_
end

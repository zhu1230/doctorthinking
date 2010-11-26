class Bingli < ActiveRecord::Base
  acts_as_commentable
normalize_attributes :zhusu
  has_one :bingli_info,:autosave=>true
  has_many :chubu_details#,:conditions=>"chubu_has is not null" 
  has_many :fuzhu_details#,:conditions=>"fuzhu_has is not null"
  has_many :question_details#,:conditions=>"yiwen_has is not null"
  has_many :attachments
  belongs_to :user
validates_length_of :zhusu, :within => 3..50, :on => :save,  :too_long => I18n.t("activerecord.errors.messages.bingli.zhusu.too_long_content"),:too_short => I18n.t("activerecord.errors.messages.bingli.zhusu.too_short_content")
accepts_nested_attributes_for :fuzhu_details, :allow_destroy => true, :reject_if => proc { |obj| ( obj['content'].blank? && (obj['attachments_attributes'].blank? || obj['attachments_attributes'].values.detect {|a|a["_destroy"].blank? && (!a['file'].blank? || !a['edit_file'].blank?)}.nil?)) } #pp obj;obj['fuzhu_type_id'].blank? || 
accepts_nested_attributes_for :chubu_details, :allow_destroy => true, :reject_if => proc { |obj| obj['content'].blank? }
accepts_nested_attributes_for :question_details, :allow_destroy => true, :reject_if => proc { |obj| obj['content'].blank? }
default_value_for :age, nil
default_value_for :sex, nil
default_value_for :marriage,0
  acts_as_ferret :fields => [:zhusu, :yibanqingkuang,:zhuyaozhengzhuang,:xianbingshi,:tigejiancha,:jiwang,:final]
	def keshi_id
		self.bingli_info.keshi.id
	end

#  validates_
end

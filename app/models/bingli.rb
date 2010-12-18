class Bingli < ActiveRecord::Base
  acts_as_commentable
normalize_attributes :zhusu
attr_accessible :zhusu,:age,:sex,:marriage,:yibanqingkuang,:zhuyaozhengzhuang,:xianbingshi,:jiwang,:buchong,:final,:tigejiancha,:yibanbuchong,:zongbuchong,:fuzhu_details_attributes,:chubu_details_attributes,:question_details_attributes
  has_one :bingli_info,:autosave=>true
  has_many :chubu_details#,:conditions=>"chubu_has is not null" 
  has_many :fuzhu_details#,:conditions=>"fuzhu_has is not null"
  has_many :question_details#,:conditions=>"yiwen_has is not null"
  # has_many :attachments
  belongs_to :user

validates_length_of :zhusu, :within => 3..50, :on => :save,  :too_long => I18n.t("activerecord.errors.messages.bingli.zhusu.too_long_content"),:too_short => I18n.t("activerecord.errors.messages.bingli.zhusu.too_short_content")
accepts_nested_attributes_for :fuzhu_details, :allow_destroy => true, :reject_if => proc { |obj| ( obj['content'].blank? && (obj['attachments_attributes'].blank? || obj['attachments_attributes'].values.detect {|a|a["_destroy"].blank? && (!a['file'].blank? || !a['edit_file'].blank?)}.nil?)) } #pp obj;obj['fuzhu_type_id'].blank? || 
accepts_nested_attributes_for :chubu_details, :allow_destroy => true, :reject_if => proc { |obj| obj['content'].blank? }
accepts_nested_attributes_for :question_details, :allow_destroy => true, :reject_if => proc { |obj| obj['content'].blank? }
before_destroy :destroy_associates
default_value_for :age, nil
default_value_for :sex, nil
default_value_for :marriage,0
  # acts_as_ferret :fields => [:zhusu, :yibanqingkuang,:zhuyaozhengzhuang,:xianbingshi,:tigejiancha,:jiwang,:final]
	def keshi_id
		self.bingli_info.keshi.id
	end
	# define_index do
	#    indexes zhusu
	#    indexes xianbingshi
	#    indexes jiwang
	#    indexes tigejiancha
	# indexes age
	# indexes marriage
	# indexes sex
	# indexes yibanbuchong
	# indexes zongbuchong
	# indexes final
	# indexes fuzhu_details(:content),:as => :fuzhus
	# indexes chubu_details(:content),:as => :chubus
	# indexes question_details(:content),:as => :questions
	# indexes fuzhu_details.fuzhu_type(:name),:as => :fuzhu_types,:sortable => true
	#    # indexes user(:login), :as => :author, :sortable => true
	# 	indexes bingli_info.title,:as => :title
	# 	   indexes bingli_info.tags(:name),:as => :tags
	# 	indexes bingli_info.keshi(:name),:as => :keshi
	#    has bingli_info(:id),:as => :bingli_info_id
	#    has bingli_info.keshi_id,:as => :keshi_id
	#    has bingli_info.created_at,:as => :created_at
	#     has bingli_info.user(:id),:as => :user_id
	#    has bingli_info.updated_at,:as => :updated_at
	#    has bingli_info.tags(:id),:as => :tag_ids
	#  end
#  validates_
private
def destroy_associates
	self.fuzhu_details.destroy_all
	self.chubu_details.destroy_all
	self.question_details.destroy_all
end

end

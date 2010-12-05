class BingliInfo < ActiveRecord::Base
	include Pacecar
	cattr_reader :per_page
	  @@per_page = 20
	acts_as_commentable
	
  acts_as_voteable
  acts_as_favorite
  acts_as_taggable
 can_be_flagged
	normalize_attributes :title
with_page_views :buffer_size => 5, :days => 1, :model_name => 'post'
  belongs_to :bingli,:autosave=>true
  belongs_to :user,:counter_cache=>true
  belongs_to :keshi
  # belongs_to :catelog
  has_many :bingli_comments
  # has_and_belongs_to_many :tags
  # has_many :fine,:class_name=>"UsersRankBingliInfos",:conditions=>"rank_tag='fine'"
  # has_many :perfect,:class_name=>"UsersRankBingliInfos",:conditions=>"rank_tag='perfect'"
  # has_many :hide,:class_name=>"UsersRankBingliInfos",:conditions=>"rank_tag='hide'"
validates_length_of :title, :within => 5..50, :on => :save,  :too_long => I18n.t("activerecord.errors.messages.bingli_info.title.too_long_content"),:too_short => I18n.t("activerecord.errors.messages.bingli_info.title.too_short_content")
 validates_presence_of :tag_list,:message=>"最少要写一个"
 validates_associated :bingli
 validates_presence_of :bingli
validates_presence_of :keshi_id
validates_associated :keshi
 # validates_presence_of :catelog_id
accepts_nested_attributes_for :bingli, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

  def votes
  	vote_for_count - vote_against_count
  end
  
  def getpic
    if !self.bingli.fuzhu_details.blank?
     fuzhu=self.bingli.fuzhu_details.detect{|fd|
	  !fd.attachments.blank? }
	fuzhu.attachments.first.file if fuzhu
    end
  end
	def after_validation
	    # Skip errors that won't be useful to the end user
	    filtered_errors = self.errors.reject{ |err| %{ bingli }.include?(err.first) }
	    # recollect the field names and retitlize them
	    # this was I won't be getting 'user.person.first_name' and instead I'll get
	    # 'First name'
	    filtered_errors.collect{ |err|
	      if err[0] =~ /(.+\.)?(.+)$/
	        err[0] = $2
	      end
	      err
	    }
	
	    # reset the errors collection and repopulate it with the filtered errors.
	    self.errors.clear
	    filtered_errors.each { |err| self.errors.add(*err) }
	
	  end
end

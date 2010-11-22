class BingliComment < ActiveRecord::Base
	cattr_reader :per_page
	  @@per_page = 20
	acts_as_commentable
  acts_as_voteable
  belongs_to :user,:counter_cache=>true
  belongs_to :bingli_info,:counter_cache=>true
  belongs_to :keshi
 validates_presence_of :user, :on => :create
  validates_associated :bingli_info, :on => :save
  validates_length_of :content, :within => 20..9000, :on => :create, :too_long => I18n.t("activerecord.errors.messages.bingli_comment.too_long_content"),:too_short => I18n.t("activerecord.errors.messages.bingli_comment.too_short_content")
  def vote_value
	self.vote_for_count - self.vote_against_count
	end
	
end

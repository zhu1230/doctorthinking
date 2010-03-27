class BingliComment < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user,:counter_cache=>true
  belongs_to :bingli_info,:counter_cache=>true
  belongs_to :keshi
  belongs_to :catelog
end

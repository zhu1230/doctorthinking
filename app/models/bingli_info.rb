class BingliInfo < ActiveRecord::Base
  acts_as_commentable
  acts_as_voteable
  acts_as_favorite
  belongs_to :bingli,:autosave=>true
  belongs_to :user,:counter_cache=>true
  belongs_to :keshi
  belongs_to :catelog
  has_many :bingli_comments
  has_and_belongs_to_many :tags
  has_many :fine,:class_name=>"UsersRankBingliInfos",:conditions=>"rank_tag='fine'"
  has_many :perfect,:class_name=>"UsersRankBingliInfos",:conditions=>"rank_tag='perfect'"
  has_many :hide,:class_name=>"UsersRankBingliInfos",:conditions=>"rank_tag='hide'"
 validates_presence_of :title
 validates_presence_of :catelog_id
  def getpic
    if !self.bingli.fuzhu_details.nil?
     self.bingli.fuzhu_details.each{|fd|if fd.attachments.size>0 then  return fd.attachments.at(0) else nil end}
    end
  end
end

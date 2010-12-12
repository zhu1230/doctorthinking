class Keshi < ActiveRecord::Base
	acts_as_nested_set
    # has_many :childs,
    #           :class_name=>"FuzhuType",
    #           :foreign_key => "parent_id"
	after_save :update_depth
	has_many :bingli_infos
	  # Validations
	  validates_presence_of :name
	  validates_uniqueness_of :name

	  def update_depth
	    unless self.level == self.depth
	      self.update_attribute(:depth, self.level)
	      self.children.each{|child| child.update_depth }
	    end
	  end
  def getid
    self.id
  end
end

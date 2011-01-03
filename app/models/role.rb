class Role < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  # has_many :memberships
  
  
  @@creator = nil
  
  def self.creator
    @@creator ||= Role.find_by_rolename('admin')
  end
  
  def self.admin
    @@admin ||= Role.find_by_rolename('admin')
  end
  def name
	self.rolename
end
def name=(aa)
	self.rolename=aa
  end
end

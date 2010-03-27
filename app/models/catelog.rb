class Catelog < ActiveRecord::Base
  belongs_to :keshi
#  has_many :childs,
#              :class_name=>"Catelog",
#              :foreign_key => "parent_id"
end

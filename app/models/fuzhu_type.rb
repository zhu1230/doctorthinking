class FuzhuType < ActiveRecord::Base
    has_many :childs,
              :class_name=>"FuzhuType",
              :foreign_key => "parent_id"
end

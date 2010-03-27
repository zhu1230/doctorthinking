class Meeting < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable
  belongs_to :user
  has_many :attachment_miscs, :as => :owner, :dependent => :destroy
end

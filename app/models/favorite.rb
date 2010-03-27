class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :bingli_info
end

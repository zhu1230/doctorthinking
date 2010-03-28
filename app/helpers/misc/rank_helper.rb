module Misc::RankHelper
  def rank_bingli_comment? bingli_comment_id
    return true if UsersRankBingliInfos.count(:conditions=>["user_id=:user_id and thetime > :thetime",{:user_id=>current_user.id,:thetime=>Time.new.beginning_of_day()}])>2
    UsersRankBingliComments.exists?(:bingli_comment_id=>bingli_comment_id,:user_id=>current_user.id)
  end
  def rank_bingli_info? bingli_info_id
    return true if UsersRankBingliInfos.count(:conditions=>["user_id=:user_id and thetime > :thetime",{:user_id=>current_user.id,:thetime=>Time.new.beginning_of_day()}])>2
    UsersRankBingliInfos.exists?(:bingli_info_id=>bingli_info_id,:user_id=>current_user.id)
  end
end

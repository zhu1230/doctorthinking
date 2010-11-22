class AddDefaultToCount < ActiveRecord::Migration
  def self.up
		change_column_default :bingli_infos, :vote_for_count, 0
		change_column_default :bingli_infos, :vote_against_count, 0
		change_column_default :bingli_comments, :vote_for_count, 0
		change_column_default :bingli_comments, :vote_against_count, 0
  end

  def self.down
		change_column_default :bingli_comments, :vote_against, null
		change_column_default :bingli_comments, :vote_for_count, null
		change_column_default :bingli_infos, :vote_against, null
		change_column_default :bingli_infos, :vote_for_count, null
  end
end
class AddCounterOfVote < ActiveRecord::Migration
  def self.up
		change_table :bingli_infos do |t|
		  t.integer :vote_for_count
		  t.integer :vote_against_count
		end
		change_table :bingli_comments do |t|
		  t.integer :vote_for_count
		  t.integer :vote_against_count
		end
		# rename_column :bingli_infos, :vote_against, :vote_against_count
		BingliInfo.find(:all).each do |v|
			BingliInfo.update_counters v.id,:vote_for_count => v.votes_for,:vote_against_count => v.votes_against
		end
		BingliComment.find(:all).each do |v|
			BingliComment.update_counters v.id,:vote_for_count => v.votes_for,:vote_against_count => v.votes_against
		end
  end

  def self.down
		rename_column :table_name, :new_column_name, :column_name
		change_column_default :bingli_infos, :vote_againt, "old default"
		change_table :bingli_comments do |t|
		end
		change_table :bingli_infos do |t|
		end
  end
end
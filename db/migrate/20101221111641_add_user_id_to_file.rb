class AddUserIdToFile < ActiveRecord::Migration
  def self.up
		add_column :wysihat_files, :user_id, :integer
		add_column :wysihat_files, :used, :boolean
		add_column :meeting_attaches,:user_id,:integer
		add_column :meeting_attaches, :used, :boolean
  end

  def self.down
		remove_column :wysihat_files, :user_id
  end
end
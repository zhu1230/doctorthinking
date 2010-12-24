class AddMeetingId < ActiveRecord::Migration
  def self.up
		add_column :meeting_attaches, :meeting_id, :integer
  end

  def self.down
		remove_column :meeting_attaches, :meeting_id
  end
end
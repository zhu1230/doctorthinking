class AddUserId < ActiveRecord::Migration
  def self.up
				add_column :shared_resources, :user_id, :integer
  end

  def self.down
		remove_column :shared_resources, :user_id
  end
end
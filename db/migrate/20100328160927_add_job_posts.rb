class AddJobPosts < ActiveRecord::Migration
  def self.up
		change_table :job_posts do |t|
		  t.integer :user_id,:null=>false
		end
		
  end

  def self.down
	remove_column :job_posts, :user_id
  end
end
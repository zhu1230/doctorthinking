class AddPageviewToMeeting < ActiveRecord::Migration
  def self.up
    add_column :meetings, :page_views_counter, :integer, :default => 0
    add_index :meetings, :page_views_counter
  end

  def self.down
  end
end

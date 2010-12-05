class AddPageViewsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :page_views_counter, :integer, :default => 0
    add_index :users, :page_views_counter
  end

  def self.down
  end
end

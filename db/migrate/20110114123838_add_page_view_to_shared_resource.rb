class AddPageViewToSharedResource < ActiveRecord::Migration
  def self.up
    add_column :shared_resources, :page_views_counter, :integer, :default => 0
    add_index :shared_resources, :page_views_counter
  end

  def self.down
  end
end

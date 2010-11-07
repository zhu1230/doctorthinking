class AddPageViewsToBingliInfo < ActiveRecord::Migration
  def self.up
    add_column :bingli_infos, :page_views_counter, :integer, :default => 0
    add_index :bingli_infos, :page_views_counter
  end

  def self.down
    remove_index :bingli_infos, :page_views_counter
    remove_column :bingli_infos, :page_views_counter
  end
end

class ChangeSharefile < ActiveRecord::Migration
  def self.up
		change_table :shared_files do |t|
		  t.text :description
		  t.integer :down_count,:default => 0
		end
  end

  def self.down
		change_table :shared_files do |t|
		end
  end
end
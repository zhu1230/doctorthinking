class AddCategory < ActiveRecord::Migration
  def self.up
		change_table :shared_files do |t|
		  t.string :category
		end
  end

  def self.down
		change_table :shared_files do |t|
		end
  end
end
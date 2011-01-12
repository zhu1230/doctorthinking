class AddSharedResource < ActiveRecord::Migration
  def self.up
		create_table :shared_resources, :force => true do |t|
		  t.string :title
			t.string :description
			t.integer :down_count
			t.string :category
		  t.timestamps
		end
		remove_column :shared_files, :title 
		remove_column :shared_files, :down_count 
		remove_column :shared_files, :description
		 	remove_column :shared_files, :category
		add_column :shared_files, :shared_resource_id, :integer
  end

  def self.down
		remove_column :table_name, :column_name

		drop_table :shared_resources
  end
end
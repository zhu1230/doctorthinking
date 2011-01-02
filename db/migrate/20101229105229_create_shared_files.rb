class CreateSharedFiles < ActiveRecord::Migration
  def self.up
    create_table :shared_files do |t|
		t.string :title
		  t.string     :file_file_name     
	      t.string     :file_content_type  
	      t.integer    :file_file_size     
	      t.datetime   :file_updated_at
	t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :shared_files
  end
end

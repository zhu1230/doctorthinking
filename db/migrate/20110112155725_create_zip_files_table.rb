class CreateZipFilesTable < ActiveRecord::Migration
  def self.up
		change_table :shared_resources do |t|
		  	  t.string     :zip_file_file_name     
		      t.string     :zip_file_content_type  
		      t.integer    :zip_file_file_size     
		      t.datetime   :zip_file_updated_at
		end
  end

  def self.down
		# drop_table :zip_files
  end
end
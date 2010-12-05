class AddPhotoToEvent < ActiveRecord::Migration
  def self.up
		change_table :events do |t|
		 t.string :photo_file_name
	      t.string :photo_content_type
	     t.integer :photo_file_size
	   t.datetime :photo_updated_at
		end
  end

  def self.down
		 remove_column :events, :avatar_file_name
	     remove_column :events, :avatar_content_type
	     remove_column :events, :avatar_file_size
	   remove_column :events, :avatar_updated_at
  end
end
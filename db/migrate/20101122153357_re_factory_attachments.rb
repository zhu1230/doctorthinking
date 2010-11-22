class ReFactoryAttachments < ActiveRecord::Migration
  def self.up
    drop_table :attachments
		create_table :attachments, :force => true do |t|
		  t.string     :file_file_name     
	      t.string     :file_content_type  
	      t.integer    :file_file_size     
	      t.datetime   :file_updated_at    
	      t.timestamps
		end
  end

  def self.down

  end
end
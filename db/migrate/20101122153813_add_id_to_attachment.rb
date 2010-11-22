class AddIdToAttachment < ActiveRecord::Migration
  def self.up
		change_table :attachments do |t|
		  t.integer :fuzhu_detail_id,:null => false
		end
  end

  def self.down
		change_table :attachments do |t|
		end
  end
end
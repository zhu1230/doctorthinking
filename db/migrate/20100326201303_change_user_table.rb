class ChangeUserTable < ActiveRecord::Migration
  def self.up
		change_table :users do |t|
		  t.column :name,:string,:default=>""
		t.column :jifen,:integer,:default=>0
		t.column :bingli_infos_count,:integer,:default=>0
		t.column :bingli_comments_count,:integer,:default=>0
		t.column :keshi_id,:integer,:default=>0
		t.column :zhicheng,:string,:default=>""
		end
		
  end

  def self.down
		change_table :users do |t|
		end
  end
end
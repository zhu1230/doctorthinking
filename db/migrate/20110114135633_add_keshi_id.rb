class AddKeshiId < ActiveRecord::Migration
  def self.up
		change_table :shared_resources do |t|
		  t.integer :keshi_id
		end
  end

  def self.down
		change_table :shared_resources do |t|
		end
  end
end
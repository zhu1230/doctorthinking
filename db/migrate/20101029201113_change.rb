class Change < ActiveRecord::Migration
  def self.up
		change_table :fuzhu_types do |t|
		  t.rename :title, :name
		end
  end

  def self.down
		change_table :fuzhu_types do |t|
			t.rename :name, :title
			
		end
  end
end
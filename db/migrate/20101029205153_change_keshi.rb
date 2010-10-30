class ChangeKeshi < ActiveRecord::Migration
  def self.up
		change_table :keshis do |t|
		  t.rename :title,:name
		  t.integer :parent_id
	      t.integer :lft
          t.integer :rgt
		  t.integer :depth
		end
  end

  def self.down
		change_table :keshis do |t|
			t.rename :name, :title
			
		end
  end
end
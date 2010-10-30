class ChangeTypes < ActiveRecord::Migration
  def self.up
		change_table :fuzhu_types do |t|
			t.integer :lft
			t.integer :rgt
			t.integer :depth
		end
  end

  def self.down
		change_table :fuzhu_types do |t|

		end
  end
end
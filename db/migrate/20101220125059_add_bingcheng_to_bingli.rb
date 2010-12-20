class AddBingchengToBingli < ActiveRecord::Migration
  def self.up
		change_table :binglis do |t|
		  t.text :bingcheng
		end
  end

  def self.down
		change_table :binglis do |t|
		end
  end
end
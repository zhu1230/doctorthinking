class ChangeBingliComment < ActiveRecord::Migration
  def self.up
		change_table :bingli_comments do |t|
		  t.rename :thetime, :created_at
		  t.datetime :updated_at
		end
  end

  def self.down
		change_table :bingli_comments do |t|
		end
  end
end
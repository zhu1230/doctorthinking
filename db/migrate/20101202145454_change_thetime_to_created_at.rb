class ChangeThetimeToCreatedAt < ActiveRecord::Migration
  def self.up
		rename_column :bingli_infos, :thetime, :created_at
		rename_column :meetings, :thetime, :created_at
		change_table :bingli_infos do |t|
		  t.datetime :updated_at
		end
  end

  def self.down
  end
end
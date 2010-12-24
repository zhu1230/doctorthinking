class AlterMeetings < ActiveRecord::Migration
  def self.up
		change_table :meetings do |t|
		  t.rename :arrange_time, :start_time
		  t.datetime :end_time
		  t.datetime :updated_at
		end
  end

  def self.down
		change_table :meetings do |t|
		end
  end
end
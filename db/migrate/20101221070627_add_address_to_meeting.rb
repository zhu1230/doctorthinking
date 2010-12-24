class AddAddressToMeeting < ActiveRecord::Migration
  def self.up
		change_table :meetings do |t|
		  t.rename :address, :country
		  t.string :state
		  t.string :city
		end
  end

  def self.down
		change_table :meetings do |t|
		end
  end
end
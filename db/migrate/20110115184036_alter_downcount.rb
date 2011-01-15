class AlterDowncount < ActiveRecord::Migration
  def self.up
		# change_column_default :shared_resources, :down_count, 0
		change_column :shared_resources, :down_count, :integer,:null => false,:default => 0
  end

  def self.down
		# change_column :table_name, :column_name, :string
		# change_column_default :shared_resources, :down_count, "old default"
  end
end
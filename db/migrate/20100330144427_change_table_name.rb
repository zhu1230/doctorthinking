class ChangeTableName < ActiveRecord::Migration
  def self.up
		rename_table :tags_bingli_infos, :bingli_infos_tags
  end

  def self.down
		rename_table :bingli_infos_tags, :tags_bingli_infos
  end
end
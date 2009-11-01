class AddTagLineToHighlights < ActiveRecord::Migration
  def self.up
    add_column :highlights, :excerpt, :string
  end

  def self.down
    remove_column :highlights, :excerpt
  end
end

class AddProcessedToHighlights < ActiveRecord::Migration
  def self.up
    add_column :highlights,:with_body, :boolean, :default => false
  end

  def self.down
    remove_column :highlights,:with_body
  end
end

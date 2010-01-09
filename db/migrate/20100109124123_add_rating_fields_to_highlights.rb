class AddRatingFieldsToHighlights < ActiveRecord::Migration
  def self.up
    add_column :highlights, :rating_count, :integer, :default => 0
    add_column :highlights, :rating_total, :decimal, :default => 0
    add_column :highlights, :rating_avg,   :decimal, :precision => 10, :scale => 2, :default => 0
  end

  def self.down
    remove_column :highlights, :rating_count, :rating_total, :rating_avg
  end
end

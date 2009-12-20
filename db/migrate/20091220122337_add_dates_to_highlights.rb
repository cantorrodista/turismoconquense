class AddDatesToHighlights < ActiveRecord::Migration
  def self.up
    add_column :highlights, :start_date, :datetime
    add_column :highlights, :end_date, :datetime   
  end

  def self.down
    remove_column :highlights, :start_date
    remove_column :highlights, :end_date
  end
end

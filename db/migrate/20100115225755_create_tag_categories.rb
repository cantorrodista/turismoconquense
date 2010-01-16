class CreateTagCategories < ActiveRecord::Migration
  def self.up
    create_table :tag_categories do |t|
      t.column :tag_id, :integer
      t.column :category_id, :integer
      t.column :position, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :tag_categories
  end
end

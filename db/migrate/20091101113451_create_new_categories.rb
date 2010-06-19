class CreateNewCategories < ActiveRecord::Migration
  def self.up
    create_table :highlight_categories do |t|
        t.column :highlight_id, :integer
        t.column :category_id, :integer
      end

      add_index :highlight_categories, [:highlight_id, :category_id], :name => 'highlight_categories_index', :unique => true

  end

  def self.down
    drop_table :highlight_categories
  end
end

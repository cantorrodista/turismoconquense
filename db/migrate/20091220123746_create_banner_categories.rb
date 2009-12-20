class CreateBannerCategories < ActiveRecord::Migration
  def self.up
    create_table :banner_categories do |t|
        t.column :banner_id, :integer
        t.column :category_id, :integer
      end

      add_index :banner_categories, [:banner_id, :category_id], :name => 'banner_categories_index', :unique => true

  end

  def self.down
    drop_table :banner_categories
  end
end

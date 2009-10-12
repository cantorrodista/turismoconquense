class CreateBanners < ActiveRecord::Migration
  def self.up
    create_table :banners do |t|
      t.string :title
      t.text :body
      t.string :url
      t.integer :width
      t.integer :height
      t.integer :position
      t.integer :advertiser_id
      t.timestamps
    end
  end

  def self.down
    drop_table :banners
  end
end

class CreateBanners < ActiveRecord::Migration
  def self.up
    create_table :banners do |t|
      t.string :title
      t.text :body
      t.string :url
      t.integer :width
      t.integer :height
      t.string :location
      t.integer :position
      t.integer :advertiser_id
      t.string :image_file_name,    :null => true
      t.string :image_mime_type,    :null => true, :limit => 64
      t.timestamps
    end
  end

  def self.down
    drop_table :banners
  end
end


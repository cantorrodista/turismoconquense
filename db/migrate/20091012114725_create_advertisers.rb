class CreateAdvertisers < ActiveRecord::Migration
  def self.up
    create_table :advertisers do |t|
      t.string :name
      t.string :url
      t.text :description
      
      t.string :logo_file_name,    :null => true
      t.string :logo_mime_type,    :null => true, :limit => 64
      
      t.timestamps
    end
  end

  def self.down
    drop_table :advertisers
  end
end

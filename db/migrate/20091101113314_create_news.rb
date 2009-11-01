class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :highlights do |t|
      t.string :name,            :null => false
      t.string :nicename,        :null => false
      t.text :summary,           :null => true
      t.text :body,              :null => true
      t.boolean :main_featured,       :null => false, :default => false
      t.boolean :featured,       :null => false, :default => false
      t.boolean :published,      :null => false, :default => false
      t.boolean :closed,         :null => false, :default => false
      t.datetime :date          
      t.timestamps
    end
  end

  def self.down
    drop_table :highlights
  end
end

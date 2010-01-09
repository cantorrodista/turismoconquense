class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :commentable, :polymorphic => true
      t.string :uri, :limit => 64
      t.string :name, :limit => 128
      t.string :email, :limit => 128
      t.string :IP, :limit => 15
      t.text :message
      t.boolean :published, :null => false, :default => false
      t.datetime :created_at, :null => false
    end
    add_index :comments, [:commentable_type, :commentable_id, :created_at], :name => "commentable_type_and_commentable_id_and_created_at"
  end

  def self.down
    drop_table :comments
  end
end

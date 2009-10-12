class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email,               :null => false, :limit => 120
      t.string :login,               :null => false, :limit => 120
      t.integer :login_count,        :null => false, :default => 0
      t.string :crypted_password,    :null => false
      t.string :password_salt,       :null => false
      t.string :persistence_token,   :null => false
      t.string :perishable_token,    :null => false
      t.boolean :admin,              :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

class AddNicenameToAdvertisers < ActiveRecord::Migration
  def self.up
    add_column :advertisers, :nicename, :string
  end

  def self.down
    remove_column :advertisers, :nicename
  end
end

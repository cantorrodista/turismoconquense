class Ratings < ActiveRecord::Migration
  def self.up
    # ActiveRecord::Base.create_ratings_table
    # Esto hace lo siguiente:
    create_table :ratings do |t|
      t.column :rater_id,   :integer
      t.column :rated_id,   :integer
      t.column :rated_type, :string
      t.column :rating,     :decimal 
    end

    add_index :ratings, :rater_id
    add_index :ratings, [:rated_type, :rated_id]

  end

  def self.down
    drop_table :ratings rescue nil
  end
end

# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100109124123) do

  create_table "advertisers", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.string   "logo_file_name"
    t.string   "logo_mime_type", :limit => 64
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nicename"
  end

  create_table "assets", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "attachings_count",  :default => 0
    t.datetime "created_at"
    t.datetime "data_updated_at"
  end

  create_table "attachings", :force => true do |t|
    t.integer  "attachable_id"
    t.integer  "asset_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachings", ["asset_id"], :name => "index_attachings_on_asset_id"
  add_index "attachings", ["attachable_id"], :name => "index_attachings_on_attachable_id"

  create_table "banner_categories", :force => true do |t|
    t.integer "banner_id"
    t.integer "category_id"
  end

  add_index "banner_categories", ["banner_id", "category_id"], :name => "banner_categories_index", :unique => true

  create_table "banners", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "url"
    t.integer  "width"
    t.integer  "height"
    t.string   "location"
    t.integer  "position"
    t.integer  "advertiser_id"
    t.string   "image_file_name"
    t.string   "image_mime_type", :limit => 64
    t.boolean  "active",                        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "nicename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",    :default => true
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "uri",              :limit => 64
    t.string   "name",             :limit => 128
    t.string   "email",            :limit => 128
    t.string   "IP",               :limit => 15
    t.text     "message"
    t.boolean  "published",                       :default => false, :null => false
    t.datetime "created_at",                                         :null => false
  end

  add_index "comments", ["commentable_type", "commentable_id", "created_at"], :name => "commentable_type_and_commentable_id_and_created_at"

  create_table "highlight_categories", :force => true do |t|
    t.integer "highlight_id"
    t.integer "category_id"
  end

  add_index "highlight_categories", ["highlight_id", "category_id"], :name => "highlight_categories_index", :unique => true

  create_table "highlights", :force => true do |t|
    t.string   "name",                                                       :default => "",    :null => false
    t.string   "nicename",                                                   :default => "",    :null => false
    t.text     "summary"
    t.text     "body"
    t.boolean  "main_featured",                                              :default => false, :null => false
    t.boolean  "featured",                                                   :default => false, :null => false
    t.boolean  "published",                                                  :default => false, :null => false
    t.boolean  "closed",                                                     :default => false, :null => false
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "excerpt"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "rating_count",                                               :default => 0
    t.integer  "rating_total",  :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.decimal  "rating_avg",                  :precision => 10, :scale => 2, :default => 0.0
  end

  create_table "ratings", :force => true do |t|
    t.integer "rater_id"
    t.integer "rated_id"
    t.string  "rated_type"
    t.integer "rating",     :limit => 10, :precision => 10, :scale => 0
  end

  add_index "ratings", ["rated_type", "rated_id"], :name => "index_ratings_on_rated_type_and_rated_id"
  add_index "ratings", ["rater_id"], :name => "index_ratings_on_rater_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",             :limit => 120, :default => "",    :null => false
    t.string   "login",             :limit => 120, :default => "",    :null => false
    t.integer  "login_count",                      :default => 0,     :null => false
    t.string   "crypted_password",                 :default => "",    :null => false
    t.string   "password_salt",                    :default => "",    :null => false
    t.string   "persistence_token",                :default => "",    :null => false
    t.string   "perishable_token",                 :default => "",    :null => false
    t.boolean  "admin",                            :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

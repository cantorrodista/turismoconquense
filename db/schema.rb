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

ActiveRecord::Schema.define(:version => 20091101165422) do

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
  end

  create_table "highlight_categories", :force => true do |t|
    t.integer "highlight_id"
    t.integer "category_id"
  end

  add_index "highlight_categories", ["highlight_id", "category_id"], :name => "highlight_categories_index", :unique => true

  create_table "highlights", :force => true do |t|
    t.string   "name",          :default => "",    :null => false
    t.string   "nicename",      :default => "",    :null => false
    t.text     "summary"
    t.text     "body"
    t.boolean  "main_featured", :default => false, :null => false
    t.boolean  "featured",      :default => false, :null => false
    t.boolean  "published",     :default => false, :null => false
    t.boolean  "closed",        :default => false, :null => false
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "excerpt"
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

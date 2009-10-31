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

ActiveRecord::Schema.define(:version => 20091012120039) do

  create_table "advertisers", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "description"
    t.string   "logo_file_name"
    t.string   "logo_mime_type", :limit => 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
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

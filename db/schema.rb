# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120401141806) do

  create_table "affiliates", :force => true do |t|
    t.string   "affiliate_name"
    t.text     "remarketing_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "affiliates", ["affiliate_name"], :name => "index_affiliates_on_affiliate_name"
  add_index "affiliates", ["remarketing_code"], :name => "index_affiliates_on_remarketing_code", :length => {"remarketing_code"=>100}

  create_table "clicks", :force => true do |t|
    t.integer  "link_id"
    t.string   "ref_url"
    t.string   "ref_ip"
    t.string   "ref_domain"
    t.string   "ref_language"
    t.string   "ref_browser"
    t.string   "ref_os"
    t.string   "ref_platform"
    t.string   "ref_keyword"
    t.boolean  "sale",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clicks", ["link_id"], :name => "index_clicks_on_link_id"

  create_table "links", :force => true do |t|
    t.integer  "affiliate_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["id"], :name => "index_links_on_id"
  add_index "links", ["url"], :name => "index_links_on_url"

  create_table "users", :force => true do |t|
    t.string   "username",   :limit => 50, :null => false
    t.string   "email",      :limit => 50, :null => false
    t.string   "password",   :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

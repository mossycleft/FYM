# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120506115226) do

  create_table "affiliates", :force => true do |t|
    t.string   "affiliate_name"
    t.text     "remarketing_code"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "affiliates", ["affiliate_name"], :name => "index_affiliates_on_affiliate_name"
  add_index "affiliates", ["remarketing_code"], :name => "index_affiliates_on_remarketing_code", :length => {"remarketing_code"=>100}

  create_table "clicks", :force => true do |t|
    t.integer  "link_id"
    t.string   "click_uuid"
    t.string   "ref_user_agent"
    t.string   "ref_url"
    t.string   "ref_ip"
    t.string   "ref_browser"
    t.string   "ref_os"
    t.string   "ref_platform"
    t.string   "ref_keyword"
    t.boolean  "sale",           :default => false
    t.boolean  "real_click",     :default => true
    t.boolean  "processed",      :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "clicks", ["click_uuid"], :name => "index_clicks_on_click_uuid"
  add_index "clicks", ["link_id"], :name => "index_clicks_on_link_id"
  add_index "clicks", ["processed"], :name => "index_clicks_on_processed"
  add_index "clicks", ["real_click"], :name => "index_clicks_on_real_click"
  add_index "clicks", ["sale"], :name => "index_clicks_on_sale"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feeds", :force => true do |t|
    t.string   "itemid"
    t.string   "title"
    t.text     "description"
    t.string   "product_type"
    t.string   "google_product_category"
    t.string   "link"
    t.string   "price"
    t.string   "condition"
    t.string   "brand"
    t.string   "shipping_weight"
    t.string   "mpn"
    t.string   "image_link"
    t.string   "availability"
    t.string   "gtin"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "links", :force => true do |t|
    t.integer  "affiliate_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "links", ["affiliate_id"], :name => "index_links_on_affiliate_id"
  add_index "links", ["id"], :name => "index_links_on_id"
  add_index "links", ["name"], :name => "index_links_on_name"
  add_index "links", ["url"], :name => "index_links_on_url"

  create_table "users", :force => true do |t|
    t.string   "username",   :limit => 50, :null => false
    t.string   "email",      :limit => 50, :null => false
    t.string   "password",   :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

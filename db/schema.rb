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

ActiveRecord::Schema.define(:version => 20121009171211) do

  create_table "brand_matches", :force => true do |t|
    t.string   "match_list"
    t.string   "exclude_list"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "position"
  end

  create_table "classifications", :force => true do |t|
    t.string   "key"
    t.string   "name"
    t.string   "type"
    t.string   "keyword"
    t.string   "branded"
    t.string   "engine"
    t.string   "country"
    t.string   "tld"
    t.string   "keyword_cloud"
    t.string   "display_country"
    t.string   "display_site"
    t.string   "display_product"
    t.string   "display_date"
    t.string   "driver_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "cloud_matches", :force => true do |t|
    t.string   "match_list"
    t.integer  "cloud_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  add_index "cloud_matches", ["cloud_id"], :name => "index_cloud_matches_on_cloud_id"

  create_table "clouds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dashboard_browsers", :force => true do |t|
    t.string   "name"
    t.integer  "visits"
    t.integer  "form_completes"
    t.date     "start_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "dashboard_clouds", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.integer  "page_views"
    t.integer  "form_completes"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "dashboard_driver_types", :force => true do |t|
    t.string   "driver_type"
    t.integer  "visits"
    t.integer  "form_completes"
    t.date     "start_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "dashboard_offer_types", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.integer  "form_views"
    t.integer  "form_completes"
    t.decimal  "form_complete_rate"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "dashboard_trended_metrics", :force => true do |t|
    t.date     "date"
    t.integer  "visits"
    t.integer  "form_completes"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "dashboard_video_names", :force => true do |t|
    t.string   "name"
    t.integer  "video_starts"
    t.integer  "video_completes"
    t.date     "start_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

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

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "suite_list"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "suites", :force => true do |t|
    t.string   "name"
    t.string   "suite_list"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "upload_files", :force => true do |t|
    t.string   "filename"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end

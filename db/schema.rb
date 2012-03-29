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

ActiveRecord::Schema.define(:version => 20120325231817) do

  create_table "attachments", :force => true do |t|
    t.string   "attachment"
    t.string   "content_type"
    t.integer  "file_size"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["post_id"], :name => "index_attachments_on_post_id"

  create_table "categories", :force => true do |t|
    t.integer  "messageboard_id"
    t.string   "name",            :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.integer  "width"
    t.integer  "height"
    t.string   "orientation"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messageboards", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "theme"
    t.string   "security",           :default => "public"
    t.string   "posting_permission", :default => "anonymous"
    t.integer  "site_id",            :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count",       :default => 0
    t.integer  "posts_count",        :default => 0
    t.string   "title"
  end

  add_index "messageboards", ["name", "site_id"], :name => "index_messageboards_on_name_and_site_id", :unique => true

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_email"
    t.text     "content"
    t.string   "ip"
    t.string   "filter",          :default => "bbcode"
    t.string   "source",          :default => "web"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id"
    t.integer  "messageboard_id"
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"

  create_table "private_users", :force => true do |t|
    t.integer  "private_topic_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "level"
    t.integer  "user_id"
    t.integer  "messageboard_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_seen"
  end

  add_index "roles", ["last_seen"], :name => "index_roles_on_last_seen"
  add_index "roles", ["messageboard_id"], :name => "index_roles_on_messageboard_id"
  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sites", :force => true do |t|
    t.integer "user_id"
    t.string  "subdomain",            :default => "thredded"
    t.string  "permission",           :default => "public"
    t.string  "cname_alias"
    t.string  "title"
    t.text    "description"
    t.string  "cached_domain"
    t.string  "home",                 :default => "messageboards"
    t.string  "email_from",           :default => "My Messageboard Mail-Bot <noreply@mysite.com>"
    t.string  "email_subject_prefix", :default => "[My Messageboard] "
    t.boolean "default_site",         :default => false
    t.string  "theme"
  end

  add_index "sites", ["cached_domain"], :name => "index_sites_on_cached_domain"

  create_table "topics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "last_user_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "messageboard_id"
    t.string   "type"
    t.integer  "posts_count",     :default => 0
    t.string   "attribs",         :default => "[]"
    t.boolean  "sticky",          :default => false
    t.integer  "category_id"
  end

  add_index "topics", ["category_id"], :name => "index_topics_on_category_id"
  add_index "topics", ["messageboard_id"], :name => "index_topics_on_messageboard_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",                           :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",                           :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "name"
    t.boolean  "superadmin",                          :default => false,                        :null => false
    t.integer  "posts_count",                         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count",                        :default => 0
    t.string   "time_zone",                           :default => "Eastern Time (US & Canada)"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

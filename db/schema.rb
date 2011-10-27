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

ActiveRecord::Schema.define(:version => 20111027130202) do

  create_table "games", :force => true do |t|
    t.string    "name"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "portals", :force => true do |t|
    t.string "name"
    t.string "short_name"
    t.string "url"
    t.string "pattern"
    t.string "color",      :default => "000000"
  end

  create_table "requests", :force => true do |t|
    t.integer "game_id"
    t.string  "remote_id"
    t.string  "url"
    t.integer "portal_id"
  end

  create_table "user_portal_accounts", :force => true do |t|
    t.integer "user_id"
    t.integer "portal_id"
    t.string  "username"
  end

  create_table "user_votes", :force => true do |t|
    t.integer "user_id"
    t.integer "request_id"
  end

  add_index "user_votes", ["user_id", "request_id"], :name => "index_user_votes_on_user_id_and_request_id", :unique => true

  create_table "users", :force => true do |t|
    t.string    "username",                                    :null => false
    t.string    "email"
    t.string    "crypted_password"
    t.string    "salt"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "remember_me_token"
    t.timestamp "remember_me_token_expires_at"
    t.integer   "points",                       :default => 0
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end

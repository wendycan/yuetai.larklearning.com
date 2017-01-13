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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170113163500) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "template"
    t.integer  "user_id"
    t.string   "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language",      default: "html"
    t.integer  "visited_count", default: 0
  end

  create_table "comments", force: true do |t|
    t.string   "text"
    t.integer  "article_id"
    t.integer  "user_id"
    t.integer  "liked_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notebooks", force: true do |t|
    t.string   "title"
    t.text     "notes"
    t.string   "citation"
    t.string   "authors"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.integer  "location"
    t.string   "chapter"
    t.string   "section"
    t.string   "type"
    t.string   "color_type"
    t.text     "content"
    t.text     "note"
    t.integer  "notebook_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["article_id"], name: "index_taggings_on_article_id"
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                      default: "",                                                                      null: false
    t.string   "encrypted_password",         default: "",                                                                      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,                                                                       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "authentication_token"
    t.integer  "level",                      default: 0
    t.text     "desc",                       default: ""
    t.string   "github",                     default: "https://github.com/"
    t.string   "webchat",                    default: "http://g0.ftp.larklearning.com/yuetai/images/default_user_webchat.png"
    t.string   "avator",                     default: "http://g0.ftp.larklearning.com/yuetai/images/default_user_avator.png"
    t.integer  "words_count",                default: 0
    t.string   "notebook_email_to"
    t.string   "notebook_email_to_password"
    t.string   "notebook_email_from"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

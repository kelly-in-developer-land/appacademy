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

ActiveRecord::Schema.define(version: 20150516001011) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "commenter_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "post_id"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["post_id"], name: "index_comments_on_post_id"

  create_table "post_subs", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "sub_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_subs", ["post_id", "sub_id"], name: "index_post_subs_on_post_id_and_sub_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.text     "content"
    t.integer  "sub_id"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["sub_id", "author_id"], name: "index_posts_on_sub_id_and_author_id"

  create_table "subs", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "moderator_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "subs", ["moderator_id"], name: "index_subs_on_moderator_id"
  add_index "subs", ["title"], name: "index_subs_on_title", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "session_token"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["password_digest"], name: "index_users_on_password_digest", unique: true
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true

end

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

ActiveRecord::Schema.define(version: 20150911144554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "compliments", force: :cascade do |t|
    t.integer  "complimenter_id",                 null: false
    t.integer  "complimentee_id",                 null: false
    t.text     "text"
    t.boolean  "private",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emoji_reactions", force: :cascade do |t|
    t.string   "emoji"
    t.integer  "user_id",           null: false
    t.integer  "reactionable_id",   null: false
    t.string   "reactionable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emoji_reactions", ["reactionable_type", "reactionable_id"], name: "index_emoji_reactions_on_reactionable_type_and_reactionable_id", using: :btree

  create_table "quotes", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quoter_id",  null: false
    t.integer  "quotee_id",  null: false
  end

  create_table "uphearts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "compliment_id"
  end

  add_index "uphearts", ["compliment_id"], name: "index_uphearts_on_compliment_id", using: :btree
  add_index "uphearts", ["user_id"], name: "index_uphearts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slack_id"
  end

end

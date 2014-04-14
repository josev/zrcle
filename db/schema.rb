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

ActiveRecord::Schema.define(version: 20140414161533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comment_likes", force: true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comment_replies", force: true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "goal_id"
    t.integer  "user_id"
    t.text     "comment"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "to_user_id"
  end

  create_table "follow_goals", force: true do |t|
    t.integer  "user_id"
    t.integer  "follow_goal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
  end

  create_table "follow_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "follow_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
  end

  create_table "goal_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "goal_messages", force: true do |t|
    t.integer  "from_user_id"
    t.integer  "to_goal_id"
    t.text     "message"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goal_rates", force: true do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.integer  "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goal_reminds", force: true do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.integer  "frequently"
    t.time     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goal_steps", force: true do |t|
    t.integer  "goal_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "goal_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.integer  "goal_category_id"
    t.text     "expected_result"
    t.date     "date"
    t.integer  "goal_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.integer  "level_number"
    t.integer  "required_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "country"
    t.text     "description"
  end

  create_table "user_configurations", force: true do |t|
    t.integer  "user_id"
    t.boolean  "notification"
    t.boolean  "new_message"
    t.boolean  "new_follower"
    t.boolean  "replies"
    t.boolean  "likes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_goals", force: true do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private"
  end

  create_table "user_levels", force: true do |t|
    t.integer  "user_id"
    t.integer  "level_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_messages", force: true do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.text     "message"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_steps", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.integer  "goal_step_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.date     "oauth_expires_at"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "image"
  end

end

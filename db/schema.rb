# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_13_120405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.string "content"
    t.integer "votes"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_answers_on_deleted_at"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_bookmarks_on_question_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "content"
    t.integer "votes"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "heading"
    t.string "description"
    t.integer "votes"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_questions_on_deleted_at"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "questions_tags", id: false, force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "tag_id", null: false
    t.index ["question_id", "tag_id"], name: "index_questions_tags_on_question_id_and_tag_id"
    t.index ["tag_id", "question_id"], name: "index_questions_tags_on_tag_id_and_question_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tags_users", id: false, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "user_id", null: false
    t.index ["tag_id", "user_id"], name: "index_tags_users_on_tag_id_and_user_id"
    t.index ["user_id", "tag_id"], name: "index_tags_users_on_user_id_and_tag_id"
  end

  create_table "user_votes", force: :cascade do |t|
    t.integer "value"
    t.integer "votable_id"
    t.string "votable_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_votes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "reputation"
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "bookmarks", "questions"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "user_votes", "users"
end

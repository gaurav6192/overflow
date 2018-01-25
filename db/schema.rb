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

ActiveRecord::Schema.define(version: 20180123203446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_stats", force: :cascade do |t|
    t.integer "score", default: 0, null: false
    t.integer "view_count", default: 0, null: false
    t.datetime "last_activity_date"
    t.bigint "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["answer_id"], name: "index_answer_stats_on_answer_id"
    t.index ["deleted_at"], name: "index_answer_stats_on_deleted_at"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_answers_on_deleted_at"
    t.index ["post_id"], name: "index_answers_on_post_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "badges", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_badges_on_deleted_at"
  end

  create_table "badges_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "badge_id", null: false
  end

  create_table "comment_stats", force: :cascade do |t|
    t.integer "score", default: 0, null: false
    t.bigint "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["comment_id"], name: "index_comment_stats_on_comment_id"
    t.index ["deleted_at"], name: "index_comment_stats_on_deleted_at"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.datetime "deleted_at"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "edits", force: :cascade do |t|
    t.jsonb "editable_content", default: "{}", null: false
    t.string "editable_type"
    t.bigint "editable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_edits_on_deleted_at"
    t.index ["editable_type", "editable_id"], name: "index_edits_on_editable_type_and_editable_id"
    t.index ["user_id"], name: "index_edits_on_user_id"
  end

  create_table "post_stats", force: :cascade do |t|
    t.integer "score", default: 0, null: false
    t.integer "view_count", default: 0, null: false
    t.datetime "last_activity_date"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_post_stats_on_deleted_at"
    t.index ["post_id"], name: "index_post_stats_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "title"
    t.text "body"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_posts_on_deleted_at"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "tag_id", null: false
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer "score", default: 0, null: false
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "recommendation_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_recommendations_on_deleted_at"
    t.index ["post_id"], name: "index_recommendations_on_post_id"
    t.index ["recommendation_id"], name: "index_recommendations_on_recommendation_id"
  end

  create_table "revisions", force: :cascade do |t|
    t.jsonb "revisionable_content", default: "{}", null: false
    t.string "revisionable_type"
    t.bigint "revisionable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_revisions_on_deleted_at"
    t.index ["revisionable_type", "revisionable_id"], name: "index_revisions_on_revisionable_type_and_revisionable_id"
    t.index ["user_id"], name: "index_revisions_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "auth_token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_sessions_on_deleted_at"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.string "statusable_type"
    t.bigint "statusable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_statuses_on_deleted_at"
    t.index ["statusable_type", "statusable_id"], name: "index_statuses_on_statusable_type_and_statusable_id"
    t.index ["user_id"], name: "index_statuses_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tags_on_deleted_at"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "tags_users", id: false, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "user_stats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "reputation_count", default: 0, null: false
    t.integer "vote_count", default: 0, null: false
    t.datetime "last_voted_at"
    t.datetime "last_reputation_changed_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_user_stats_on_deleted_at"
    t.index ["user_id"], name: "index_user_stats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "user_name", null: false
    t.string "email", null: false
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
  end

  create_table "vote_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "score_change", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_vote_types_on_deleted_at"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "vote_type_id"
    t.bigint "user_stat_id"
    t.string "voteable_type"
    t.bigint "voteable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_votes_on_deleted_at"
    t.index ["user_stat_id"], name: "index_votes_on_user_stat_id"
    t.index ["vote_type_id"], name: "index_votes_on_vote_type_id"
    t.index ["voteable_type", "voteable_id"], name: "index_votes_on_voteable_type_and_voteable_id"
  end

  add_foreign_key "answer_stats", "answers"
  add_foreign_key "answers", "posts"
  add_foreign_key "answers", "users"
  add_foreign_key "comment_stats", "comments"
  add_foreign_key "comments", "users"
  add_foreign_key "edits", "users"
  add_foreign_key "post_stats", "posts"
  add_foreign_key "posts", "users"
  add_foreign_key "recommendations", "posts"
  add_foreign_key "recommendations", "posts", column: "recommendation_id"
  add_foreign_key "revisions", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "statuses", "users"
  add_foreign_key "tags", "users"
  add_foreign_key "user_stats", "users"
  add_foreign_key "votes", "user_stats"
  add_foreign_key "votes", "vote_types"
end

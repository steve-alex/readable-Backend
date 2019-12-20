# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_20_194021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.string "google_id"
    t.string "title"
    t.string "subtitle"
    t.string "authors"
    t.string "publisher"
    t.string "categories"
    t.string "description"
    t.string "language"
    t.string "image_url"
    t.string "published_date"
    t.string "page_count"
    t.string "google_average_rating"
    t.string "rating_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "copies", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_copies_on_book_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_follows_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "likeable_type"
    t.bigint "likeable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "progresses", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "published"
    t.index ["user_id"], name: "index_progresses_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "summary"
    t.string "content"
    t.integer "rating"
    t.integer "sentiment"
    t.bigint "user_id", null: false
    t.bigint "copy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["copy_id"], name: "index_reviews_on_copy_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shelf_copies", force: :cascade do |t|
    t.bigint "shelf_id", null: false
    t.bigint "copy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["copy_id"], name: "index_shelf_copies_on_copy_id"
    t.index ["shelf_id"], name: "index_shelf_copies_on_shelf_id"
  end

  create_table "shelves", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_shelves_on_user_id"
  end

  create_table "updates", force: :cascade do |t|
    t.integer "page_number"
    t.bigint "progress_id", null: false
    t.bigint "copy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["copy_id"], name: "index_updates_on_copy_id"
    t.index ["progress_id"], name: "index_updates_on_progress_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "fullname"
    t.boolean "fullnameviewable"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "gender"
    t.string "city"
    t.boolean "cityviewable"
    t.string "about"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users"
  add_foreign_key "copies", "books"
  add_foreign_key "likes", "users"
  add_foreign_key "progresses", "users"
  add_foreign_key "reviews", "copies"
  add_foreign_key "reviews", "users"
  add_foreign_key "shelf_copies", "copies"
  add_foreign_key "shelf_copies", "shelves"
  add_foreign_key "shelves", "users"
  add_foreign_key "updates", "copies"
  add_foreign_key "updates", "progresses"
end

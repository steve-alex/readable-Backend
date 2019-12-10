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

ActiveRecord::Schema.define(version: 2019_12_10_092542) do

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "progesses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "shelfBook_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shelfBook_id"], name: "index_progesses_on_shelfBook_id"
    t.index ["user_id"], name: "index_progesses_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "shelfBook_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shelfBook_id"], name: "index_reviews_on_shelfBook_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shelf_books", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "shelf_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_shelf_books_on_book_id"
    t.index ["shelf_id"], name: "index_shelf_books_on_shelf_id"
  end

  create_table "shelves", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_shelves_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "comments", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "progesses", "shelfBooks"
  add_foreign_key "progesses", "users"
  add_foreign_key "reviews", "shelfBooks"
  add_foreign_key "reviews", "users"
  add_foreign_key "shelf_books", "books"
  add_foreign_key "shelf_books", "shelves"
  add_foreign_key "shelves", "users"
end

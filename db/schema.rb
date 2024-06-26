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

ActiveRecord::Schema[7.1].define(version: 2024_03_18_053706) do
  create_table "bookings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "start_time"
    t.string "end_time"
    t.integer "status"
    t.bigint "user_id", null: false
    t.bigint "field_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "booked_date"
    t.bigint "price_id"
    t.index ["field_type_id"], name: "index_bookings_on_field_type_id"
    t.index ["id"], name: "index_bookings_on_id"
    t.index ["price_id"], name: "fk_rails_5ebf20ad89"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_comment_id"
    t.index ["parent_comment_id"], name: "index_comments_on_parent_comment_id"
    t.index ["review_id"], name: "index_comments_on_review_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorite_field_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "field_type_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_type_id"], name: "index_favorite_field_types_on_field_type_id"
    t.index ["user_id"], name: "index_favorite_field_types_on_user_id"
  end

  create_table "field_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "field_type_name", limit: 50
    t.boolean "is_availible"
    t.bigint "field_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_id"], name: "index_field_types_on_field_id"
    t.index ["id"], name: "index_field_types_on_id"
  end

  create_table "fields", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 50
    t.text "description"
    t.string "phone_number", limit: 15
    t.string "address", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", default: 1, null: false
    t.index ["id"], name: "index_fields_on_id"
    t.index ["user_id"], name: "index_fields_on_user_id"
  end

  create_table "prices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "field_type_id", null: false
    t.index ["field_type_id"], name: "index_prices_on_field_type_id"
    t.index ["id"], name: "index_prices_on_id"
  end

  create_table "reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "field_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.integer "rating"
    t.index ["field_type_id"], name: "index_reviews_on_field_type_id"
    t.index ["id"], name: "index_reviews_on_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", limit: 50
    t.string "first_name", limit: 20
    t.string "last_name", limit: 20
    t.string "phone_number", limit: 15
    t.string "password_digest"
    t.boolean "is_active"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "activated_at"
    t.index ["id"], name: "index_users_on_id"
  end

  add_foreign_key "booking_amounts", "bookings"
  add_foreign_key "booking_amounts", "prices"
  add_foreign_key "bookings", "field_types"
  add_foreign_key "bookings", "prices"
  add_foreign_key "bookings", "users"
  add_foreign_key "comments", "comments", column: "parent_comment_id"
  add_foreign_key "comments", "reviews"
  add_foreign_key "comments", "users"
  add_foreign_key "favorite_field_types", "field_types"
  add_foreign_key "favorite_field_types", "users"
  add_foreign_key "field_types", "fields"
  add_foreign_key "fields", "users"
  add_foreign_key "prices", "field_types"
  add_foreign_key "reviews", "fields"
  add_foreign_key "reviews", "users"
end

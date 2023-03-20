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

ActiveRecord::Schema[7.1].define(version: 2023_03_20_095537) do
  create_table "gift_issue_permissions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "survey_response_uid", null: false
    t.string "telephone", null: false
    t.integer "point", null: false
    t.bigint "product_id", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["point"], name: "index_gift_issue_permissions_on_point"
    t.index ["product_id"], name: "index_gift_issue_permissions_on_product_id"
    t.index ["store_id"], name: "index_gift_issue_permissions_on_store_id"
    t.index ["survey_response_uid"], name: "index_gift_issue_permissions_on_survey_response_uid", unique: true
    t.index ["telephone"], name: "index_gift_issue_permissions_on_telephone"
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  create_table "store_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_store_categories_on_name", unique: true
  end

  create_table "stores", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "store_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_stores_on_name", unique: true
    t.index ["store_category_id"], name: "index_stores_on_store_category_id"
  end

  add_foreign_key "gift_issue_permissions", "products"
  add_foreign_key "gift_issue_permissions", "stores"
  add_foreign_key "stores", "store_categories"
end

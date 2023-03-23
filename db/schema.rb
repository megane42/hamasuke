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

ActiveRecord::Schema[7.1].define(version: 2023_03_23_072042) do
  create_table "gift_issue_permissions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "survey_response_uid", null: false
    t.string "telephone", null: false
    t.integer "point", null: false
    t.string "product_category_name", null: false
    t.string "store_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["point"], name: "index_gift_issue_permissions_on_point"
    t.index ["product_category_name"], name: "index_gift_issue_permissions_on_product_category_name"
    t.index ["store_name"], name: "index_gift_issue_permissions_on_store_name"
    t.index ["survey_response_uid"], name: "index_gift_issue_permissions_on_survey_response_uid", unique: true
    t.index ["telephone"], name: "index_gift_issue_permissions_on_telephone"
  end

  create_table "gifts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "gift_issue_permission_id", null: false
    t.string "url", null: false
    t.integer "initial_point", null: false
    t.datetime "expired_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expired_at"], name: "index_gifts_on_expired_at"
    t.index ["gift_issue_permission_id"], name: "index_gifts_on_gift_issue_permission_id", unique: true
    t.index ["initial_point"], name: "index_gifts_on_initial_point"
    t.index ["url"], name: "index_gifts_on_url", unique: true
  end

  create_table "product_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_product_categories_on_name", unique: true
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "product_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "sms_sendings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "gift_issue_permission_id", null: false
    t.datetime "sent_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gift_issue_permission_id"], name: "index_sms_sendings_on_gift_issue_permission_id", unique: true
    t.index ["sent_at"], name: "index_sms_sendings_on_sent_at"
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

  add_foreign_key "gifts", "gift_issue_permissions"
  add_foreign_key "products", "product_categories"
  add_foreign_key "sms_sendings", "gift_issue_permissions"
  add_foreign_key "stores", "store_categories"
end

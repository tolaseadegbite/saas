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

ActiveRecord::Schema[7.0].define(version: 2024_02_29_181853) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "category_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "business_code", null: false
    t.integer "products_count", default: 0, null: false
    t.integer "stores_count", default: 0, null: false
    t.integer "customers_count", default: 0, null: false
    t.index ["category_id"], name: "index_businesses_on_category_id"
    t.index ["name"], name: "index_businesses_on_name", unique: true
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "phone_number"
    t.bigint "user_id", null: false
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_customers_on_business_id"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["name"], name: "index_customers_on_name", unique: true
    t.index ["phone_number"], name: "index_customers_on_phone_number", unique: true
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.string "product_code", null: false
    t.bigint "user_id", null: false
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_products_on_business_id"
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "store_products", force: :cascade do |t|
    t.integer "quantity", null: false
    t.bigint "product_id", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "store_id"], name: "index_store_products_on_product_id_and_store_id", unique: true
    t.index ["product_id"], name: "index_store_products_on_product_id"
    t.index ["store_id"], name: "index_store_products_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "store_products_count", default: 0, null: false
    t.index ["business_id"], name: "index_stores_on_business_id"
    t.index ["name"], name: "index_stores_on_name", unique: true
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "surname", null: false
    t.string "firstname", null: false
    t.boolean "admin", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "phone_number"
    t.integer "businesses_count", default: 0, null: false
    t.integer "stores_count", default: 0, null: false
    t.integer "products_count", default: 0, null: false
    t.integer "customers_count", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "businesses", "categories"
  add_foreign_key "businesses", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "customers", "businesses"
  add_foreign_key "customers", "users"
  add_foreign_key "products", "businesses"
  add_foreign_key "products", "users"
  add_foreign_key "store_products", "products"
  add_foreign_key "store_products", "stores"
  add_foreign_key "stores", "businesses"
  add_foreign_key "stores", "users"
end

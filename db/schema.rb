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

ActiveRecord::Schema.define(version: 20180215152243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seller_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
  end

  add_index "addresses", ["seller_id"], name: "index_addresses_on_seller_id", using: :btree
  add_index "addresses", ["store_id"], name: "index_addresses_on_store_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "franchise_id"
    t.boolean  "master_admin",           default: false, null: false
    t.integer  "stores_ids",             default: [],                 array: true
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["franchise_id"], name: "index_admins_on_franchise_id", using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "apps", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "apple_certificate"
    t.string   "apple_store_url"
    t.string   "google_play_url"
    t.string   "google_api_key"
    t.string   "app_cover"
    t.boolean  "use_logo",               default: false, null: false
    t.boolean  "invalid_name",           default: false, null: false
    t.boolean  "test_mode",              default: false, null: false
    t.string   "username"
    t.string   "password_hash",          default: ""
    t.boolean  "require_authentication", default: false, null: false
  end

  add_index "apps", ["store_id"], name: "index_apps_on_store_id", using: :btree

  create_table "banks", force: :cascade do |t|
    t.integer  "seller_id"
    t.string   "name"
    t.string   "number"
    t.string   "agency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banks", ["seller_id"], name: "index_banks_on_seller_id", using: :btree

  create_table "banners", force: :cascade do |t|
    t.integer  "franchise_id"
    t.string   "image"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banners", ["franchise_id"], name: "index_banners_on_franchise_id", using: :btree

  create_table "business_translations", force: :cascade do |t|
    t.integer  "business_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
  end

  add_index "business_translations", ["business_id"], name: "index_business_translations_on_business_id", using: :btree
  add_index "business_translations", ["locale"], name: "index_business_translations_on_locale", using: :btree

  create_table "businesses", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "store_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id", using: :btree
  add_index "categories", ["store_id"], name: "index_categories_on_store_id", using: :btree

  create_table "changes", force: :cascade do |t|
    t.integer  "changeable_id"
    t.string   "changeable_type"
    t.text     "log"
    t.boolean  "checked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "name"
    t.string   "username"
    t.string   "password_hash"
    t.boolean  "blocked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.boolean  "admin",                  default: false, null: false
    t.string   "email"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "clients", ["email"], name: "index_clients_on_email", unique: true, using: :btree
  add_index "clients", ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true, using: :btree
  add_index "clients", ["store_id"], name: "index_clients_on_store_id", using: :btree

  create_table "clients_stores", force: :cascade do |t|
    t.integer "client_id"
    t.integer "store_id"
  end

  add_index "clients_stores", ["client_id"], name: "index_clients_stores_on_client_id", using: :btree
  add_index "clients_stores", ["store_id"], name: "index_clients_stores_on_store_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "franchise_id"
  end

  add_index "contacts", ["franchise_id"], name: "index_contacts_on_franchise_id", using: :btree

  create_table "department_translations", force: :cascade do |t|
    t.integer  "department_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "title"
  end

  add_index "department_translations", ["department_id"], name: "index_department_translations_on_department_id", using: :btree
  add_index "department_translations", ["locale"], name: "index_department_translations_on_locale", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
    t.string   "title"
    t.integer  "department_id"
  end

  add_index "departments", ["department_id"], name: "index_departments_on_department_id", using: :btree
  add_index "departments", ["store_id"], name: "index_departments_on_store_id", using: :btree

  create_table "departments_devices", force: :cascade do |t|
    t.integer "device_id"
    t.integer "department_id"
  end

  add_index "departments_devices", ["department_id"], name: "index_departments_devices_on_department_id", using: :btree
  add_index "departments_devices", ["device_id"], name: "index_departments_devices_on_device_id", using: :btree

  create_table "departments_stores", force: :cascade do |t|
    t.integer "department_id"
    t.integer "store_id"
  end

  add_index "departments_stores", ["department_id"], name: "index_departments_stores_on_department_id", using: :btree
  add_index "departments_stores", ["store_id"], name: "index_departments_stores_on_store_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "token"
    t.string   "push_token"
    t.string   "kind",       default: "1"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "radius"
    t.string   "locale"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.integer  "user_id"
  end

  add_index "devices", ["store_id"], name: "index_devices_on_store_id", using: :btree
  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "devices_stores", force: :cascade do |t|
    t.integer "device_id"
    t.integer "store_id"
  end

  add_index "devices_stores", ["device_id"], name: "index_devices_stores_on_device_id", using: :btree
  add_index "devices_stores", ["store_id"], name: "index_devices_stores_on_store_id", using: :btree

  create_table "franchises", force: :cascade do |t|
    t.string   "name"
    t.string   "subdomain"
    t.string   "domain"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.text     "mx_record"
    t.integer  "admin_id"
    t.integer  "trial_period", default: 30, null: false
  end

  add_index "franchises", ["admin_id"], name: "index_franchises_on_admin_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "file_processing", default: false, null: false
    t.string   "file_tmp"
    t.integer  "category_id"
    t.integer  "business_id"
    t.integer  "height",          default: 0,     null: false
    t.integer  "width",           default: 0,     null: false
  end

  add_index "images", ["business_id"], name: "index_images_on_business_id", using: :btree
  add_index "images", ["category_id"], name: "index_images_on_category_id", using: :btree
  add_index "images", ["store_id"], name: "index_images_on_store_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "number"
    t.string   "plan_name"
    t.decimal  "value",          precision: 8, scale: 2
    t.datetime "paid_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "value_real",     precision: 8, scale: 2
    t.integer  "status"
    t.string   "transaction_id"
    t.boolean  "closed",                                 default: false, null: false
    t.text     "log"
  end

  add_index "invoices", ["store_id"], name: "index_invoices_on_store_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.integer  "store_id"
    t.text     "log"
    t.boolean  "closed",      default: false, null: false
    t.string   "name"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "import_type", default: 0
    t.boolean  "success",     default: false, null: false
  end

  add_index "jobs", ["store_id"], name: "index_jobs_on_store_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.text     "description"
    t.integer  "recurring_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["recurring_id"], name: "index_logs_on_recurring_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "device_id"
    t.text     "message"
    t.datetime "read_at"
    t.integer  "kind",       default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["device_id"], name: "index_messages_on_device_id", using: :btree
  add_index "messages", ["store_id"], name: "index_messages_on_store_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["store_id"], name: "index_notifications_on_store_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "store_id"
    t.date     "card_expires_on"
    t.decimal  "value",           precision: 8, scale: 2
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_brand"
    t.string   "address"
    t.string   "zip"
    t.string   "state"
    t.string   "city"
    t.text     "log"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["store_id"], name: "index_orders_on_store_id", using: :btree

  create_table "paypals", force: :cascade do |t|
    t.string   "login"
    t.string   "password"
    t.string   "partner",      default: "PayPal"
    t.boolean  "sandbox",      default: false,    null: false
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user"
    t.integer  "franchise_id"
  end

  add_index "paypals", ["franchise_id"], name: "index_paypals_on_franchise_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string   "file"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "file_processing", default: false, null: false
    t.string   "file_tmp"
  end

  create_table "pins", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "device_id"
    t.integer  "publish_id"
    t.integer  "product_id"
    t.string   "name"
    t.string   "category_name"
    t.text     "description"
    t.text     "contact_info"
    t.decimal  "regular_price", precision: 16, scale: 2
    t.decimal  "price",         precision: 16, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "store_name"
  end

  add_index "pins", ["device_id"], name: "index_pins_on_device_id", using: :btree
  add_index "pins", ["product_id"], name: "index_pins_on_product_id", using: :btree
  add_index "pins", ["publish_id"], name: "index_pins_on_publish_id", using: :btree
  add_index "pins", ["store_id"], name: "index_pins_on_store_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.integer  "monthly_posts"
    t.integer  "stores_limit"
    t.integer  "users_count"
    t.boolean  "popular",                                  default: false, null: false
    t.boolean  "visible",                                  default: false, null: false
    t.boolean  "email_support",                            default: false, null: false
    t.boolean  "chat_support",                             default: false, null: false
    t.decimal  "price",            precision: 8, scale: 2
    t.decimal  "individual_price", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "franchise_id"
    t.decimal  "price_real",       precision: 8, scale: 2
  end

  add_index "plans", ["franchise_id"], name: "index_plans_on_franchise_id", using: :btree

  create_table "prices", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.decimal  "regular_price", precision: 16, scale: 2
    t.decimal  "price",         precision: 16, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prices", ["product_id"], name: "index_prices_on_product_id", using: :btree
  add_index "prices", ["store_id"], name: "index_prices_on_store_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "name"
    t.integer  "category_id"
    t.text     "description"
    t.text     "contact_info"
    t.decimal  "regular_price",       precision: 16, scale: 2
    t.decimal  "price",               precision: 16, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_all",                                     default: true, null: false
    t.datetime "published_all_until"
    t.string   "code"
    t.datetime "last_published_at"
    t.datetime "last_unpublished_at"
    t.string   "payment_option"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["store_id"], name: "index_products_on_store_id", using: :btree

  create_table "products_schedules", force: :cascade do |t|
    t.integer "product_id"
    t.integer "schedule_id"
  end

  add_index "products_schedules", ["product_id"], name: "index_products_schedules_on_product_id", using: :btree
  add_index "products_schedules", ["schedule_id"], name: "index_products_schedules_on_schedule_id", using: :btree

  create_table "products_stores", force: :cascade do |t|
    t.integer "product_id"
    t.integer "store_id"
  end

  add_index "products_stores", ["product_id"], name: "index_products_stores_on_product_id", using: :btree
  add_index "products_stores", ["store_id"], name: "index_products_stores_on_store_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["product_id"], name: "index_properties_on_product_id", using: :btree

  create_table "publishes", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.integer  "user_id"
    t.decimal  "price",                  precision: 16, scale: 2
    t.datetime "removed_at"
    t.datetime "published_until"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "regular_price",          precision: 16, scale: 2
    t.boolean  "published_by_corporate",                          default: false, null: false
    t.integer  "feature_level",                                   default: 0,     null: false
  end

  add_index "publishes", ["product_id"], name: "index_publishes_on_product_id", using: :btree
  add_index "publishes", ["store_id"], name: "index_publishes_on_store_id", using: :btree
  add_index "publishes", ["user_id"], name: "index_publishes_on_user_id", using: :btree

  create_table "pushes", force: :cascade do |t|
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pushes", ["store_id"], name: "index_pushes_on_store_id", using: :btree

  create_table "recurrings", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "profile_id"
    t.decimal  "value",              precision: 8, scale: 2
    t.datetime "canceled_at"
    t.string   "credit_card_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "value_real",         precision: 8, scale: 2
  end

  add_index "recurrings", ["store_id"], name: "index_recurrings_on_store_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "store_id"
    t.date     "initial"
    t.date     "final"
    t.datetime "run_at"
    t.datetime "last_run"
    t.integer  "products_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publishes_count", default: 0, null: false
  end

  add_index "schedules", ["store_id"], name: "index_schedules_on_store_id", using: :btree

  create_table "sellers", force: :cascade do |t|
    t.string   "name"
    t.string   "cell_phone"
    t.string   "phone"
    t.string   "number"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seller_id"
    t.decimal  "commission",             precision: 8, scale: 2
    t.string   "encrypted_password",                             default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                  default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "sellers_count",                                  default: 0,  null: false
    t.string   "document"
    t.integer  "stores_count",                                   default: 0,  null: false
    t.integer  "apps_count",                                     default: 0,  null: false
    t.integer  "franchise_id"
  end

  add_index "sellers", ["email"], name: "index_sellers_on_email", unique: true, using: :btree
  add_index "sellers", ["franchise_id"], name: "index_sellers_on_franchise_id", using: :btree
  add_index "sellers", ["reset_password_token"], name: "index_sellers_on_reset_password_token", unique: true, using: :btree
  add_index "sellers", ["seller_id"], name: "index_sellers_on_seller_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.integer  "plan_id"
    t.string   "name"
    t.string   "phone"
    t.string   "cell_phone"
    t.string   "contact"
    t.string   "official_email"
    t.string   "website"
    t.string   "time_zone"
    t.string   "token"
    t.string   "number"
    t.integer  "payment_option"
    t.boolean  "corporate",                                   default: false, null: false
    t.date     "trial_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
    t.integer  "users_count",                                 default: 0,     null: false
    t.integer  "stores_count",                                default: 0,     null: false
    t.string   "logo"
    t.integer  "term_version",                                default: 0,     null: false
    t.boolean  "active",                                      default: true,  null: false
    t.datetime "plan_updated_at"
    t.integer  "app_logo_id"
    t.text     "about"
    t.integer  "seller_id"
    t.boolean  "blocked",                                     default: false, null: false
    t.integer  "department_id"
    t.integer  "sub_department_id"
    t.text     "short_description"
    t.text     "keywords"
    t.string   "vender_name"
    t.string   "currency",                                    default: "USD", null: false
    t.integer  "franchise_id"
    t.string   "ancestry"
    t.integer  "ancestry_depth",                              default: 0,     null: false
    t.boolean  "free_payment",                                default: false, null: false
    t.boolean  "manual_payment",                              default: false, null: false
    t.integer  "business_id"
    t.integer  "active_stores_count",                         default: 0,     null: false
    t.boolean  "register",                                    default: false
    t.string   "short_name"
    t.boolean  "search",                                      default: true
    t.boolean  "paid",                                        default: false
    t.decimal  "price",               precision: 8, scale: 2
    t.boolean  "free",                                        default: false
  end

  add_index "stores", ["ancestry"], name: "index_stores_on_ancestry", using: :btree
  add_index "stores", ["app_logo_id"], name: "index_stores_on_app_logo_id", using: :btree
  add_index "stores", ["business_id"], name: "index_stores_on_business_id", using: :btree
  add_index "stores", ["department_id"], name: "index_stores_on_department_id", using: :btree
  add_index "stores", ["franchise_id"], name: "index_stores_on_franchise_id", using: :btree
  add_index "stores", ["plan_id"], name: "index_stores_on_plan_id", using: :btree
  add_index "stores", ["seller_id"], name: "index_stores_on_seller_id", using: :btree
  add_index "stores", ["store_id"], name: "index_stores_on_store_id", using: :btree
  add_index "stores", ["sub_department_id"], name: "index_stores_on_sub_department_id", using: :btree

  create_table "streets", force: :cascade do |t|
    t.integer  "device_id"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "streets", ["device_id"], name: "index_streets_on_device_id", using: :btree

  create_table "term_translations", force: :cascade do |t|
    t.integer  "term_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "text"
  end

  add_index "term_translations", ["locale"], name: "index_term_translations_on_locale", using: :btree
  add_index "term_translations", ["term_id"], name: "index_term_translations_on_term_id", using: :btree

  create_table "terms", force: :cascade do |t|
    t.integer  "version",    default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "store_id"
    t.boolean  "blocked",                default: false, null: false
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["store_id"], name: "index_users_on_store_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.text     "html"
    t.string   "locale"
    t.integer  "franchise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_link"
  end

  add_index "videos", ["franchise_id"], name: "index_videos_on_franchise_id", using: :btree

end

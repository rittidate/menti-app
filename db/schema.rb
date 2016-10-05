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

ActiveRecord::Schema.define(version: 20161005023243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorys_users_relations", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "value",        default: 0
    t.integer  "desire_value", default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "conversation_replies", force: :cascade do |t|
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.string   "reply"
    t.boolean  "seen"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "conversation_replies", ["conversation_id"], name: "index_conversation_replies_on_conversation_id", using: :btree
  add_index "conversation_replies", ["user_id"], name: "index_conversation_replies_on_user_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "user_one_id"
    t.integer  "user_two_id"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "categories_id"
    t.integer  "price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "courses", ["categories_id"], name: "index_courses_on_categories_id", using: :btree
  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "courses_user_relations", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "owner_id"
  end

  create_table "feed_messages", force: :cascade do |t|
    t.integer  "reciever_id"
    t.integer  "sender_id"
    t.string   "message"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follows", ["user_id"], name: "index_follows_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "transaction_id"
    t.string   "status"
    t.string   "notification_type"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "sender_id"
    t.boolean  "seen",              default: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "card_type"
    t.string   "masked_number"
    t.string   "token"
    t.string   "customer_id"
    t.boolean  "is_public",               default: true
    t.string   "company"
    t.string   "address"
    t.string   "address_ext"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country",       limit: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "giver_id"
    t.integer  "value",                    default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "courses_user_relation_id"
  end

  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "security_questions", force: :cascade do |t|
    t.string "locale", null: false
    t.string "name",   null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "transaction_type", default: 0
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "amount"
    t.string   "card_type"
    t.string   "masked_number"
    t.string   "status"
    t.string   "ref"
    t.string   "notes"
    t.datetime "transaction_date"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "course_owner_id"
  end

  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "username"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.date     "birthdate"
    t.string   "country",                  limit: 2
    t.string   "prefered_language",        limit: 2
    t.integer  "user_type"
    t.string   "mobile_phone"
    t.boolean  "terms_of_service"
    t.integer  "default_payment_id"
    t.string   "gender"
    t.integer  "security_question_id"
    t.string   "security_question_answer"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "education"
    t.string   "about"
    t.string   "program"
    t.string   "terms"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "conversation_replies", "conversations"
  add_foreign_key "conversation_replies", "users"
  add_foreign_key "courses", "users"
  add_foreign_key "follows", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "ratings", "users"
  add_foreign_key "transactions", "users"
end

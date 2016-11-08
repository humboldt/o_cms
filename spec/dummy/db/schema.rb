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

ActiveRecord::Schema.define(version: 20161105203727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "o_cms_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "icon"
    t.text     "body"
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "o_cms_galleries", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "o_cms_image_galleries", id: false, force: :cascade do |t|
    t.integer "image_id"
    t.integer "gallery_id"
  end

  add_index "o_cms_image_galleries", ["gallery_id"], name: "index_o_cms_image_galleries_on_gallery_id", using: :btree
  add_index "o_cms_image_galleries", ["image_id"], name: "index_o_cms_image_galleries_on_image_id", using: :btree

  create_table "o_cms_images", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "o_cms_pages", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.text     "excerpt"
    t.string   "featured_image"
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "published_at"
    t.integer  "parent_id"
    t.integer  "order"
  end

  create_table "o_cms_post_categories", id: false, force: :cascade do |t|
    t.integer "post_id"
    t.integer "category_id"
  end

  add_index "o_cms_post_categories", ["category_id"], name: "index_o_cms_post_categories_on_category_id", using: :btree
  add_index "o_cms_post_categories", ["post_id"], name: "index_o_cms_post_categories_on_post_id", using: :btree

  create_table "o_cms_posts", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.text     "excerpt"
    t.string   "featured_image"
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "published_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end

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

ActiveRecord::Schema.define(version: 20160309161607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "poste_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "abilities", ["poste_id"], name: "index_abilities_on_poste_id", using: :btree
  add_index "abilities", ["user_id"], name: "index_abilities_on_user_id", using: :btree

  create_table "attachinary_files", force: :cascade do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "declared_plannings", force: :cascade do |t|
    t.integer  "planning_id"
    t.json     "shifts"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "declared_plannings", ["planning_id"], name: "index_declared_plannings_on_planning_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shop_id"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["shop_id"], name: "index_memberships_on_shop_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "organisation_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organisation_memberships", ["organisation_id"], name: "index_organisation_memberships_on_organisation_id", using: :btree
  add_index "organisation_memberships", ["user_id"], name: "index_organisation_memberships_on_user_id", using: :btree

  create_table "organisations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orgpostes", force: :cascade do |t|
    t.integer  "organisation_id"
    t.integer  "poste_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "orgpostes", ["organisation_id"], name: "index_orgpostes_on_organisation_id", using: :btree
  add_index "orgpostes", ["poste_id"], name: "index_orgpostes_on_poste_id", using: :btree

  create_table "plannings", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "shop_id"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "status",     default: "Ongoing"
  end

  add_index "plannings", ["shop_id"], name: "index_plannings_on_shop_id", using: :btree
  add_index "plannings", ["user_id"], name: "index_plannings_on_user_id", using: :btree

  create_table "postes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "poste_id"
    t.integer  "planning_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "shifts", ["planning_id"], name: "index_shifts_on_planning_id", using: :btree
  add_index "shifts", ["poste_id"], name: "index_shifts_on_poste_id", using: :btree
  add_index "shifts", ["user_id"], name: "index_shifts_on_user_id", using: :btree

  create_table "shops", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organisation_id"
    t.datetime "opening_time"
    t.datetime "closing_time"
  end

  add_index "shops", ["organisation_id"], name: "index_shops_on_organisation_id", using: :btree

  create_table "shppostes", force: :cascade do |t|
    t.integer  "shop_id"
    t.integer  "poste_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "color"
  end

  add_index "shppostes", ["poste_id"], name: "index_shppostes_on_poste_id", using: :btree
  add_index "shppostes", ["shop_id"], name: "index_shppostes_on_shop_id", using: :btree

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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.boolean  "admin",                  default: false, null: false
    t.string   "phone"
    t.float    "hourly_wage"
    t.integer  "contract_hours"
    t.datetime "start_date"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "abilities", "postes"
  add_foreign_key "abilities", "users"
  add_foreign_key "declared_plannings", "plannings"
  add_foreign_key "memberships", "shops"
  add_foreign_key "memberships", "users"
  add_foreign_key "organisation_memberships", "organisations"
  add_foreign_key "organisation_memberships", "users"
  add_foreign_key "orgpostes", "organisations"
  add_foreign_key "orgpostes", "postes"
  add_foreign_key "plannings", "shops"
  add_foreign_key "plannings", "users"
  add_foreign_key "shifts", "plannings"
  add_foreign_key "shifts", "postes"
  add_foreign_key "shifts", "users"
  add_foreign_key "shops", "organisations"
  add_foreign_key "shppostes", "postes"
  add_foreign_key "shppostes", "shops"
end

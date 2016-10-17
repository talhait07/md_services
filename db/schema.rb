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

ActiveRecord::Schema.define(version: 20141124161938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "encounters", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.uuid     "site_id",                           null: false
    t.uuid     "patient_id"
    t.string   "status",           default: "open", null: false
    t.string   "first_name",                        null: false
    t.string   "last_name",                         null: false
    t.date     "birth_date",                        null: false
    t.string   "phone_number",                      null: false
    t.integer  "balance_cents",    default: 0,      null: false
    t.string   "balance_currency", default: "USD",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "encounters", ["patient_id"], name: "index_encounters_on_patient_id", using: :btree
  add_index "encounters", ["site_id"], name: "index_encounters_on_site_id", using: :btree

  create_table "oauth_access_grants", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.uuid     "resource_owner_id", null: false
    t.uuid     "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.uuid     "resource_owner_id"
    t.uuid     "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "organization_users", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.hstore   "roles"
    t.uuid     "organization_id",                    null: false
    t.uuid     "user_id",                            null: false
    t.string   "status",          default: "active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_users", ["organization_id", "user_id"], name: "index_organization_users_on_organization_id_and_user_id", unique: true, using: :btree

  create_table "organizations", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.string   "stripe_recipient_id"
    t.string   "name",                                 null: false
    t.string   "npi_number",                           null: false
    t.integer  "positions",                            null: false
    t.string   "address_1",                            null: false
    t.string   "address_2"
    t.string   "city",                                 null: false
    t.string   "state",                                null: false
    t.string   "postal_code",                          null: false
    t.string   "phone_number",                         null: false
    t.string   "url",                                  null: false
    t.integer  "sites_count",              default: 0
    t.integer  "organization_users_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["npi_number"], name: "index_organizations_on_npi_number", using: :btree
  add_index "organizations", ["stripe_recipient_id"], name: "index_organizations_on_stripe_recipient_id", using: :btree

  create_table "patients", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.uuid     "user_id",    null: false
    t.uuid     "site_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patients", ["user_id", "site_id"], name: "index_patients_on_user_id_and_site_id", unique: true, using: :btree

  create_table "payments", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.uuid     "encounter_id",                        null: false
    t.string   "charge_id"
    t.string   "status",          default: "pending", null: false
    t.integer  "amount_cents",    default: 0,         null: false
    t.string   "amount_currency", default: "USD",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["encounter_id"], name: "index_payments_on_encounter_id", using: :btree

  create_table "profiles", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.uuid     "user_id",      null: false
    t.string   "stripe_id",    null: false
    t.date     "birth_date",   null: false
    t.string   "phone_number", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["stripe_id"], name: "index_profiles_on_stripe_id", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "sites", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.uuid     "organization_id", null: false
    t.string   "name",            null: false
    t.string   "address_1",       null: false
    t.string   "address_2"
    t.string   "city",            null: false
    t.string   "state",           null: false
    t.string   "postal_code",     null: false
    t.string   "phone_number",    null: false
    t.string   "site_number",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["organization_id"], name: "index_sites_on_organization_id", using: :btree
  add_index "sites", ["site_number"], name: "index_sites_on_site_number", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v1mc()", force: true do |t|
    t.string   "email",                                           null: false
    t.string   "first_name",                                      null: false
    t.string   "last_name",                                       null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.boolean  "god",                             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end

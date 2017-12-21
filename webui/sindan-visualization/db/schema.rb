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

ActiveRecord::Schema.define(version: 20171116011017) do

  create_table "diagnosis_logs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "layer"
    t.string "log_type"
    t.integer "result"
    t.text "detail"
    t.datetime "occurred_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "log_campaign_uuid", limit: 38
    t.string "log_group"
    t.string "target"
    t.index ["log_campaign_uuid"], name: "index_diagnosis_logs_on_log_campaign_uuid"
    t.index ["occurred_at"], name: "index_diagnosis_logs_on_occurred_at"
    t.index ["result"], name: "index_diagnosis_logs_on_result"
  end

  create_table "ignore_error_results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ssid"
    t.text "ignore_log_types"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "log_campaigns", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "log_campaign_uuid", limit: 38
    t.string "mac_addr"
    t.string "os"
    t.datetime "occurred_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "ssid"
    t.index ["log_campaign_uuid"], name: "index_log_campaigns_on_log_campaign_uuid"
    t.index ["occurred_at"], name: "index_log_campaigns_on_occurred_at"
    t.index ["ssid"], name: "index_log_campaigns_on_ssid"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "login", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

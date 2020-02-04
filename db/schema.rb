# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_04_053253) do

  create_table "dns_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "record_type"
    t.string "record_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dns_records_domains", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "dns_record_id", null: false
    t.bigint "domain_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dns_record_id"], name: "index_dns_records_domains_on_dns_record_id"
    t.index ["domain_id"], name: "index_dns_records_domains_on_domain_id"
  end

  create_table "domains", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "fqdn"
    t.json "sources"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "domains_scans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "scan_id"
    t.bigint "domain_id"
    t.index ["domain_id"], name: "index_domains_scans_on_domain_id"
    t.index ["scan_id"], name: "index_domains_scans_on_scan_id"
  end

  create_table "scans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "parent_domain_id"
    t.bigint "domains_scan_id"
    t.json "sources"
    t.index ["domains_scan_id"], name: "index_scans_on_domains_scan_id"
    t.index ["parent_domain_id"], name: "index_scans_on_parent_domain_id"
  end

  add_foreign_key "dns_records_domains", "dns_records"
  add_foreign_key "dns_records_domains", "domains"
  add_foreign_key "domains_scans", "domains"
  add_foreign_key "domains_scans", "scans"
  add_foreign_key "scans", "domains", column: "parent_domain_id"
  add_foreign_key "scans", "domains_scans"
end

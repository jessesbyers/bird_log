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

ActiveRecord::Schema.define(version: 2019_12_11_161036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "birds", id: :serial, force: :cascade do |t|
    t.string "common_name"
    t.string "scientific_name"
    t.string "family"
    t.string "description"
    t.string "conservation_status"
    t.string "habitat"
    t.string "feeding_behavior"
    t.string "eggs"
    t.string "young"
    t.string "diet"
    t.string "image"
  end

  create_table "sightings", id: :serial, force: :cascade do |t|
    t.string "audubon_url"
    t.string "date"
    t.string "location"
    t.string "notes"
    t.integer "user_id"
    t.integer "bird_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end

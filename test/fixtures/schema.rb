# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 3) do

  create_table "cars", :force => true do |t|
    t.string   "brand"
    t.string   "modeltype"
    t.integer  "number_of_wheels"
    t.boolean  "steering_wheel"
    t.string   "color"
    t.string   "coachwork"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "original_values", :force => true do |t|
    t.string   "model"
    t.string   "attribute"
    t.integer  "model_id"
    t.string   "model_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "voornaam"
    t.string   "achternaam"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

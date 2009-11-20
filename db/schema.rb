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

ActiveRecord::Schema.define(:version => 20090219121506) do

  create_table "attr_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "category"
    t.integer  "parent_id",  :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_products", :id => false, :force => true do |t|
    t.integer  "product_id",  :limit => 11
    t.integer  "category_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brand_id",   :limit => 11
  end

  create_table "products_specifications", :id => false, :force => true do |t|
    t.integer  "product_id",       :limit => 11
    t.integer  "specification_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spec_attributes", :force => true do |t|
    t.string   "name"
    t.integer  "attr_type_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specifications", :force => true do |t|
    t.string   "spec_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "spec_attribute_id", :limit => 11
    t.integer  "unit_id",           :limit => 11
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.integer  "attr_type_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "system"
  end

end

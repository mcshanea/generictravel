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

ActiveRecord::Schema.define(:version => 20081201222430) do

  create_table "agents", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "telephone"
    t.string   "mobile"
    t.boolean  "active"
    t.string   "role"
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.integer  "comment_id"
    t.integer  "company_id"
  end

  create_table "bookings", :force => true do |t|
    t.integer  "agent_id"
    t.string   "departing"
    t.string   "arriving"
    t.string   "status"
    t.date     "sent_date"
    t.integer  "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "info"
    t.integer  "comment_id"
    t.integer  "company_id"
    t.integer  "agent_percentage"
    t.integer  "leader_id"
  end

  create_table "bookings_clients", :id => false, :force => true do |t|
    t.integer  "booking_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "telephone"
    t.string   "mobile"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.text     "notes"
  end

  create_table "comments", :force => true do |t|
    t.integer  "booking_id"
    t.integer  "agent_id"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.integer  "licences"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "excursions", :force => true do |t|
    t.string   "duration"
    t.date     "arrival_date"
    t.date     "departure_date"
    t.integer  "service_id"
    t.integer  "booking_id"
    t.string   "booking_reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "payment_amount"
  end

  create_table "hotels", :force => true do |t|
    t.string   "name"
    t.integer  "room_id"
    t.integer  "location_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
  end

  create_table "itineraries", :force => true do |t|
    t.string   "itinerary_type"
    t.string   "departing"
    t.string   "arriving"
    t.datetime "arrival_date"
    t.datetime "departure_date"
    t.string   "operator"
    t.integer  "booking_id"
    t.string   "booking_reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "payment_amount"
    t.integer  "hotel_id"
    t.integer  "room_id"
    t.integer  "rate_id"
  end

  create_table "locations", :force => true do |t|
    t.text     "address"
    t.string   "post_code"
    t.string   "country"
    t.string   "address_type"
    t.integer  "agent_id"
    t.integer  "service_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.float    "value"
    t.string   "payment_type"
    t.date     "processed_date"
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rates", :force => true do |t|
    t.float    "amount"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.string   "room_type"
    t.integer  "hotel_id"
    t.float    "rate"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.string   "departing"
    t.string   "arriving"
    t.string   "status"
    t.date     "from"
    t.date     "to"
    t.integer  "service_id"
    t.integer  "agent_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "venue"
    t.string   "operator"
    t.text     "description"
    t.string   "phone_number"
    t.string   "fax_number"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

end

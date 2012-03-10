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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120310183636) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.integer  "released"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlist_items", :force => true do |t|
    t.integer  "playlist_id"
    t.integer  "track_id"
    t.integer  "votes_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotify_id"
    t.integer  "previous_votes_count", :default => 0
    t.integer  "plays_count"
  end

  create_table "playlists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "is_playing"
    t.integer  "playlist_items_count", :default => 0
  end

  create_table "plays", :force => true do |t|
    t.integer  "playlist_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.string   "artist"
    t.string   "album"
    t.string   "href"
    t.float    "popularity"
    t.float    "length"
    t.integer  "playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "votes_count",       :default => 0
    t.string   "spotify_id"
    t.integer  "total_votes_count"
    t.string   "cover_url"
  end

  create_table "votes", :force => true do |t|
    t.integer  "track_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playlist_item_id"
  end

end

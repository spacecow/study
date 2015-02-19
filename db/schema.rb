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

ActiveRecord::Schema.define(:version => 20150219092905) do

  create_table "answers", :force => true do |t|
    t.integer "quiz_id",     :null => false
    t.integer "question_id", :null => false
    t.string  "string"
  end

  add_index "answers", ["question_id"], :name => "question_id"
  add_index "answers", ["quiz_id"], :name => "quiz_id"

  create_table "antonym_glossaries", :force => true do |t|
    t.integer  "glossary_id"
    t.integer  "antonym_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "glossaries", :force => true do |t|
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "reading"
  end

  create_table "glossaries_kanjis", :force => true do |t|
    t.integer  "kanji_id"
    t.integer  "glossary_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "kanjis", :force => true do |t|
    t.string   "symbol"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kanjis_meanings", :force => true do |t|
    t.integer  "kanji_id"
    t.integer  "meaning_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locales", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lookups", :force => true do |t|
    t.integer  "glossary_id"
    t.integer  "sentence_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "meanings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer "quiz_id", :null => false
    t.string  "string"
  end

  create_table "quizzes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sentences", :force => true do |t|
    t.string   "english"
    t.string   "japanese"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "project_id"
  end

  create_table "similar_glossaries", :force => true do |t|
    t.integer  "glossary_id"
    t.integer  "similar_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "similarities", :force => true do |t|
    t.integer  "kanji_id"
    t.integer  "similar_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "synonym_glossaries", :force => true do |t|
    t.integer  "glossary_id"
    t.integer  "synonym_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "translations", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "locale_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "name"
    t.string   "email"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "roles_mask"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "password_digest"
  end

end

# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_327_162_028) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'bookmarks', force: :cascade do |t|
    t.string 'title'
    t.bigint 'folder_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['folder_id'], name: 'index_bookmarks_on_folder_id'
  end

  create_table 'email_verification_tokens', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_email_verification_tokens_on_user_id'
  end

  create_table 'folders', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'images', force: :cascade do |t|
    t.string 'title'
    t.string 'url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'likes', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'message_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['message_id'], name: 'index_likes_on_message_id'
    t.index %w[user_id message_id], name: 'index_likes_on_user_id_and_message_id', unique: true
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'messages', force: :cascade do |t|
    t.bigint 'room_id', null: false
    t.bigint 'user_id', null: false
    t.text 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['room_id'], name: 'index_messages_on_room_id'
    t.index ['user_id'], name: 'index_messages_on_user_id'
  end

  create_table 'notes', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
    t.integer 'position', default: 1, null: false
    t.index %w[user_id position], name: 'unique_user_id_position', unique: true
    t.index ['user_id'], name: 'index_notes_on_user_id'
  end

  create_table 'password_reset_tokens', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_password_reset_tokens_on_user_id'
  end

  create_table 'room_members', force: :cascade do |t|
    t.bigint 'room_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[room_id user_id], name: 'index_room_members_on_room_id_and_user_id', unique: true
    t.index ['room_id'], name: 'index_room_members_on_room_id'
    t.index ['user_id'], name: 'index_room_members_on_user_id'
  end

  create_table 'rooms', force: :cascade do |t|
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'sessions', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'user_agent'
    t.string 'ip_address'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_sessions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.boolean 'verified', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'bookmarks', 'folders'
  add_foreign_key 'email_verification_tokens', 'users'
  add_foreign_key 'likes', 'messages'
  add_foreign_key 'likes', 'users'
  add_foreign_key 'messages', 'rooms'
  add_foreign_key 'messages', 'users'
  add_foreign_key 'notes', 'users'
  add_foreign_key 'password_reset_tokens', 'users'
  add_foreign_key 'room_members', 'rooms'
  add_foreign_key 'room_members', 'users'
  add_foreign_key 'sessions', 'users'
end

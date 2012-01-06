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

ActiveRecord::Schema.define(:version => 1) do

  create_table "sofa_blog_comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.boolean  "is_approved", :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sofa_blog_comments", ["post_id", "created_at"], :name => "index_sofa_blog_comments_on_post_id_and_created_at"
  add_index "sofa_blog_comments", ["post_id", "is_approved", "created_at"], :name => "index_sofa_blog_comments_on_post_and_approved_and_created_at"

  create_table "sofa_blog_posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "excerpt"
    t.string   "author"
    t.boolean  "is_published",            :default => false, :null => false
    t.integer  "comments_count",          :default => 0,     :null => false
    t.integer  "approved_comments_count", :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sofa_blog_posts", ["created_at"], :name => "index_sofa_blog_posts_on_created_at"
  add_index "sofa_blog_posts", ["is_published", "created_at"], :name => "index_sofa_blog_posts_on_is_published_and_created_at"

  create_table "sofa_blog_taggings", :force => true do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at"
  end

  add_index "sofa_blog_taggings", ["post_id", "tag_id", "created_at"], :name => "index_sofa_blog_taggings_on_post_id_tag_id_created_at", :unique => true

  create_table "sofa_blog_tags", :force => true do |t|
    t.string  "name"
    t.integer "taggings_count"
  end

  add_index "sofa_blog_tags", ["name", "taggings_count"], :name => "index_sofa_blog_tags_on_name_and_taggings_count", :unique => true
  add_index "sofa_blog_tags", ["taggings_count"], :name => "index_sofa_blog_tags_on_taggings_count"

end

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

  create_table "blog_comments", :force => true do |t|
    t.integer  "post_id",                         :null => false
    t.string   "author",                          :null => false
    t.string   "email",                           :null => false
    t.text     "content"
    t.boolean  "is_published", :default => false, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "blog_comments", ["post_id", "created_at"], :name => "index_blog_comments_on_post_id_and_created_at"
  add_index "blog_comments", ["post_id", "is_published", "created_at"], :name => "index_blog_comments_on_post_published_created"

  create_table "blog_posts", :force => true do |t|
    t.string   "title",                                          :null => false
    t.string   "slug",                                           :null => false
    t.text     "content"
    t.string   "excerpt",      :limit => 1024
    t.string   "author"
    t.integer  "year",         :limit => 4,                      :null => false
    t.integer  "month",        :limit => 2,                      :null => false
    t.boolean  "is_published",                 :default => true, :null => false
    t.datetime "published_at",                                   :null => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "blog_posts", ["created_at"], :name => "index_blog_posts_on_created_at"
  add_index "blog_posts", ["is_published", "created_at"], :name => "index_blog_posts_on_is_published_and_created_at"
  add_index "blog_posts", ["is_published", "year", "month", "slug"], :name => "index_blog_posts_on_published_year_month_slug"

  create_table "blog_taggings", :force => true do |t|
    t.integer "post_id", :null => false
    t.integer "tag_id",  :null => false
  end

  add_index "blog_taggings", ["post_id", "tag_id"], :name => "index_blog_taggings_on_post_tag", :unique => true

  create_table "blog_tags", :force => true do |t|
    t.string  "name",                              :null => false
    t.boolean "is_category",    :default => false, :null => false
    t.integer "taggings_count", :default => 0,     :null => false
  end

  add_index "blog_tags", ["name", "taggings_count"], :name => "index_blog_tags_on_name_and_taggings_count", :unique => true
  add_index "blog_tags", ["taggings_count"], :name => "index_blog_tags_on_taggings_count"

end

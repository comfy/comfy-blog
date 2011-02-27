class CreateSofaBlog < ActiveRecord::Migration
  def self.up
    create_table :blog_posts do |t|
      t.string  :title
      t.text    :content
      t.string  :author
      t.boolean :published, :null => false, :default => false
      t.integer :comments_count, :null => false, :default => 0
      t.integer :approved_comments_count, :null => false, :default => 0
      t.timestamps
    end
    add_index :blog_posts, [:published, :title]
    add_index :blog_posts, [:title, :published]
    
    
    create_table :blog_comments do |t|
      t.integer :blog_post_id
      t.string :name
      t.string :email
      t.text :content
      t.boolean :approved, :null => false, :default => false
      t.timestamps
    end
    add_index :blog_comments, :blog_post_id
    
    
    create_table :blog_tags do |t|
      t.string :name
      t.integer :blog_taggings_count
    end
    add_index :blog_tags, [:name, :blog_taggings_count], :unique => true
    add_index :blog_tags, :blog_taggings_count


    create_table :blog_taggings do |t|
      t.integer :blog_post_id
      t.integer :blog_tag_id
      t.datetime :created_at
    end
    add_index :blog_taggings, [:blog_post_id, :blog_tag_id, :created_at], :unique => true, :name => 'index_blog_taggings_on_post_id_tag_id_created_at'
    
  end
  
  def self.down
    drop_table :blog_posts
    drop_table :blog_comments
    drop_table :blog_tags
    drop_table :blog_taggings
  end
end

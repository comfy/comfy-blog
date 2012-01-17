class CreateSofaBlog < ActiveRecord::Migration
  
  def self.up
    create_table :blog_posts do |t|
      t.string  :title,           :null => false
      t.string  :slug,            :null => false
      t.text    :content
      t.string  :excerpt,         :limit => 1024
      t.string  :author
      t.integer :year,            :null => false, :limit => 4
      t.integer :month,           :null => false, :limit => 2
      t.boolean :is_published,    :null => false, :default => false
      t.timestamps
    end
    add_index :blog_posts, [:is_published, :year, :month, :slug],
      :name => 'index_blog_posts_on_published_year_month_slug'
    add_index :blog_posts, [:is_published, :created_at]
    add_index :blog_posts, :created_at
    
    create_table :blog_comments do |t|
      t.integer :post_id
      t.string  :author
      t.string  :email
      t.text    :content
      t.boolean :is_published, :null => false, :default => false
      t.timestamps
    end
    add_index :blog_comments, [:post_id, :created_at]
    add_index :blog_comments, [:post_id, :is_published, :created_at],
      :name => 'index_blog_comments_on_post_published_created'
      
    create_table :blog_tags do |t|
      t.string  :name
      t.integer :taggings_count
    end
    add_index :blog_tags, [:name, :taggings_count], :unique => true
    add_index :blog_tags, :taggings_count
    
    create_table :blog_taggings do |t|
      t.integer   :post_id
      t.integer   :tag_id
      t.datetime  :created_at
    end
    add_index :blog_taggings, [:post_id, :tag_id, :created_at], :unique => true,
      :name => 'index_blog_taggings_on_post_tag_created'
  end
  
  def self.down
    drop_table :sofa_blog_posts
    drop_table :sofa_blog_comments
    drop_table :sofa_blog_tags
    drop_table :sofa_blog_taggings
  end
end

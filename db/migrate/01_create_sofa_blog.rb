class CreateSofaBlog < ActiveRecord::Migration
  
  def self.up
    create_table :sofa_blog_posts do |t|
      t.string  :title
      t.text    :content
      t.string  :author
      t.boolean :is_published,    :null => false, :default => false
      t.integer :comments_count,  :null => false, :default => 0
      t.integer :approved_comments_count, :null => false, :default => 0
      t.timestamps
    end
    add_index :sofa_blog_posts, :created_at
    add_index :sofa_blog_posts, [:is_published, :created_at]
    
    create_table :sofa_blog_comments do |t|
      t.integer :post_id
      t.string  :name
      t.string  :email
      t.text    :content
      t.boolean :is_approved, :null => false, :default => false
      t.timestamps
    end
    add_index :sofa_blog_comments, [:post_id, :created_at]
    add_index :sofa_blog_comments, [:post_id, :is_approved, :created_at],
      :name => 'index_sofa_blog_comments_on_post_and_approved_and_created_at'
  end
  
  def self.down
    drop_table :sofa_blog_posts
    drop_table :sofa_blog_comments
  end
end

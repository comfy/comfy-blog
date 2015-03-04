class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :comfy_blog_tags do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :comfy_blog_taggings do |t|
      t.references :tag
      t.references :post, index: true
      t.timestamps
    end
  end

  def self.down
    drop_table :comfy_blog_tags
    drop_table :comfy_blog_taggings
  end
end

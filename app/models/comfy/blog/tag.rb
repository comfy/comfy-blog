class Comfy::Blog::Tag < ActiveRecord::Base

  self.table_name = 'comfy_blog_tags'

  has_many :taggings
  has_many :posts, through: :taggings
end

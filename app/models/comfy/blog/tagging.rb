class Comfy::Blog::Tagging < ActiveRecord::Base

  self.table_name = 'comfy_blog_taggings'

  belongs_to :post
  belongs_to :tag
end

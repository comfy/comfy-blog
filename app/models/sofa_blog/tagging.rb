class SofaBlog::Tagging < ActiveRecord::Base

  set_table_name :sofa_blog_taggings

  # -- Relationships --------------------------------------------------------
  belongs_to :post
  belongs_to :tag, :counter_cache => true

end

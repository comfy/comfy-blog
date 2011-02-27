class BlogTagging < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  belongs_to :blog_post
  belongs_to :blog_tag, :counter_cache => true
  
end

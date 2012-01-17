class Blog::Tagging < ActiveRecord::Base
  
  set_table_name :blog_taggings
  
  # -- Relationships --------------------------------------------------------
  belongs_to :post
  belongs_to :tag, :counter_cache => true
  
  # -- Callbacks ------------------------------------------------------------
  after_destroy :destroy_tag
  
protected
  
  def destroy_tag
    self.tag.destroy if self.tag.taggings.count == 0
  end
  
end
